import os
import subprocess
import re
import numpy as np

'''
 获取两个模式结合下的最优解
 Pass: InjectPass_profiling_multicache
'''

'''
 injectOffiling.pass
 现有env:
 // cmake
 APP_NAME
 SOURCE_CPP
 INJECT_BIT
 // hipPass
 BYPASS_ENABLE
 IR_ENABLE
 // injectPass
 KERNEL
 SEARCH
 MODES
 STOREBYPASS
 STOREMODE
 '''

'''
首先获取划分:修改pass为 GroupDivisonPass
bash scripts/gen_binary.sh 
修改pass为 InjectPass_profiling
python3 system/instruction_level_control.py
'''
# 获取该APP的信息
app_name = "convolutionSeparable_hip_cols"
kernel_name = ["_Z9conv_colsPfPKfS1_iii"] # 考虑一个应用有多个kernel
os.environ['SOURCE_CPP'] = "OFF"

## env相关信息
os.environ['APP_NAME'] = app_name

negInfinity = -999999
HighThes1 = 1.5 # group theshold
LowThes1 = -20 # group lowtheshold
HighThes2 = 0.1 # store theshold
HighThes3 = 1 # load theshold
# weight = 0.1 # combi影响单条load的权重
pattern = "(.*) [mu]s"
iteration = 1 # 运行次数
baseline_iteration = 5 # baseline运行次数
log_name = "./system/Weight/%s.txt" % app_name
input_name_pre = "./system/group/%s/" % app_name

# algorithm 1
def read_input(kernel):
    input_name = input_name_pre + "%s.txt" % kernel
    print("read_input: %s" % input_name,"-----------------------")
    with open('%s' % log_name, 'a') as file:
        file.write("read_input: %s\n" % input_name)

    groups, loads = [], []
    with open(input_name, 'r') as file:
        next(file)
        for line in file:
            line_values = line.split()
            groups.append(line_values)
            for value in line_values:
                loads.append([value])
    print("groups", groups)
    print("loads", loads)
    return groups, loads

def getPassEnvironFromMap(bypass_policy):
    strSearch = "_".join([key[1:] for key in bypass_policy.keys()])
    strMode = "_".join(str(value) for value in bypass_policy.values())
    print("strSearch:", strSearch)
    print("strMode:", strMode)
    return strSearch, strMode

def getPassEnvironFromG(g, mode):
    strSearch = "_".join([v[1:] for v in g])
    strMode = "_".join(str(mode) for _ in range(len(g)))
    print("strSearch:", strSearch)
    print("strMode:", strMode)
    return strSearch, strMode

def offline_profiling(strSearch, strMode, storebypass, storemode, baseline_time): # storemode: int, 前三个: str
    print("search: %s, mode: %s" % (strSearch, strMode))
    inject_bit = strSearch
    if len(strSearch) > 50:
        inject_bit = "long_goups_%d" % (len(strSearch))
    print("inject_bit: %s" % inject_bit )

    os.environ['SEARCH'] = strSearch
    os.environ['MODES'] = strMode
    os.environ['STOREMODE'] = str(storemode)
    os.environ['STOREBYPASS'] = storebypass
    # 编译--------------------------------------
    os.environ['INJECT_BIT'] = inject_bit
    os.environ['BYPASS_ENABLE'] = "ON"
    os.environ['IR_ENABLE'] = "OFF"
    ## 删除相关文件
    cmd = f"rm -rf ./lib/{app_name} && rm -rf build"
    result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行
    if result.returncode == 0:
        # print("success\n")
        pass
    else:
        print("rm failed\n")
    ## 编译
    cmd = f"cmake -S . -B build/{app_name}/{inject_bit}"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"CMake configuration failed for TARGET_NAME={inject_bit}")
        print("Output:\n", e.stdout.decode())

    cmd = f"cmake --build build/{app_name}/{inject_bit} -j64"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print("CMake build failed!")
        print("Output:\n", e.stdout.decode())
    
    # 运行--------------------------------------
    time = 0
    cmd = f"./bin/{app_name}/{app_name}_{inject_bit}"
    for i in range(iteration):
        result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行？？
        if result.returncode == 0:
            # print("success\n")
            pass
        else:
            print("failed\n")
        lines = result.stdout.decode().split('\n')  # 分割字符串成多行
        last_line = lines[-2]  # 取最后一行, ms后面一定要有"\n",最后一个数组是空
        time += eval(re.match(pattern, last_line).group(1))
    time /= iteration
    improve = 100 * (baseline_time - time) / baseline_time
    speedup = baseline_time / time
    return time, speedup, improve

def baseline_profiling():
    with open('%s' % log_name, 'a') as file:
        file.write("baseline_profiling #####\n")
    inject_bit = "cache"
    os.environ['INJECT_BIT'] = inject_bit
    os.environ['BYPASS_ENABLE'] = "OFF"
    os.environ['IR_ENABLE'] = "ON"
    # os.environ['STOREBYPASS'] = "false"
    # 编译---------------------------------------------
    ## 删除相关文件
    cmd = f"rm -rf ./lib/{app_name} && rm -rf build"
    result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行？？
    if result.returncode == 0:
        # print("success\n")
        pass
    else:
        print("rm failed\n")
    ## 编译
    cmd = f"cmake -S . -B build/{app_name}/{inject_bit}"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print(f"CMake configuration failed for TARGET_NAME={inject_bit}")
        print("Output:\n", e.stdout.decode())

    cmd = f"cmake --build build/{app_name}/{inject_bit} -j64"
    try:
        subprocess.run(cmd, shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    except subprocess.CalledProcessError as e:
        print("CMake build failed!")
        print("Output:\n", e.stdout.decode())
    
    # 运行--------------------------------------
    time = 0
    cmd = f"./bin/{app_name}/{app_name}_{inject_bit}"
    for i in range(baseline_iteration):
        result = subprocess.run(cmd, shell=True, capture_output=True) # 阻塞运行？？
        if result.returncode == 0:
            # print("success\n")
            pass
        else:
            print("failed\n")
        lines = result.stdout.decode().split('\n')  # 分割字符串成多行
        last_line = lines[-2]  # 取最后一行, ms后面一定要有"\n",最后一个数组是空
        time += eval(re.match(pattern, last_line).group(1))
    time /= baseline_iteration

    with open('%s' % log_name, 'a') as file:
        file.write("baseline_time: %f\n" % time)

    return time


def global_loads_bypass_algorithm(groups, loads):
    modes = [0, 1]
    NONTEMPORAL = 0
    VOLATILE = 1
    storebypass = "false"
    storemode = 0

    with open('%s' % log_name, 'a') as file:
        file.write("offline_profiling -----------\n")
    groups_profiling = [[0]*len(groups) for _ in range(len(modes))] # 每个group对应的profiling，外部长度为groups，内部长度为modes
    loads_map = [{},{}] # map，key：每个load，value：对应的profiling; 二维
    # worse_loads = []
    # 首先进行offline_profiling, 两个mode均进行，并且进行记录-----------------
    for i in range(len(groups)):
        g = groups[i]
        print("offline_profiling:", g, "-----------")
        for mode in modes:
            print("mode:",mode)
            # offline_profiling change, environ list, 打印一下【时间，speedup，improve】
            strSearch, strMode = getPassEnvironFromG(g, mode)
            time, speedup, offp = offline_profiling(strSearch, strMode, storebypass, storemode, baseline_time)
            groups_profiling[mode][i] = offp
            # TODO: 将 offline_profilling 小于 LowThes or 其他一定数值里的load 不进行profiling，从而节省时间
            # if (offp <= LowThes1):
            #     worse_loads.extend(g)
            if len(g) == 1:
                loads_map[mode]["%s" % g[0]] = offp

            with open('%s' % log_name, 'a') as file:
                file.write("%s, mode: %d, baseline: %f, time: %f, offp: %f, speedup: %f\n" % ('_'.join(g), mode, baseline_time, time, offp, speedup))

    for g in loads:
        print("offline_profiling:",g,"--------------")
        for mode in modes:
            if (g[0] in loads_map[mode].keys()):
                continue
            # if (g[0] in worse_loads): # 小于LowThes不会再去看单个了, 不进行profiling，从而节省时间
            #     continue
            print("mode:",mode)
            print("%s in loads but not in goups" % g[0])
            strSearch, strMode = getPassEnvironFromG(g, mode)
            time, speedup, offp = offline_profiling(strSearch, strMode, storebypass, storemode, baseline_time)
            loads_map[mode]["%s" % g[0]] = offp
            with open('%s' % log_name, 'a') as file:
                file.write("%s, mode: %d, baseline: %f, time: %f, offp: %f, speedup: %f\n" % ('_'.join(g), mode, baseline_time, time, offp, speedup))
    # print(groups_pofiling)
    # print(loads_map)
   
    # total_score = 0.0
    # policy = []
    for weight in np.arange(0.0, 0.6, 0.1):
        print("weight: %f ----------------------------" % weight)
        with open('%s' % log_name, 'a') as file:
            file.write("weight: %f -----------\n" % weight)
        policy_map = {} # key：bypass的load数，value：bypass的mode
        combi = [negInfinity]*len(groups) # 记录group两个模式下确定的combi，没确定则为初始化的负无穷
        combi_record = [[0]*len(groups) for _ in range(len(modes))] #记录所有combi
        # with open('%s' % log_name, 'a') as file:
        #     file.write("algorithm2 -----------\n")
        for i in range(len(groups)):
            g = groups[i]
            print("algorithm2:",g,"-------------")
            # 先确定整个g，有无其适合的模式选择
            for mode in modes:
                # 计算combi_g
                combi_g = groups_profiling[mode][i]
                # if (combi_g <= LowThes1): # 如果groups_profiling的整个就已经很影响了，直接走 TODO：是否直接单条load都不看
                #     with open('%s' % log_name, 'a') as file:
                #         file.write("%s, mode: %d, combi_g(groups_profiling): %f is too low\n" % ('_'.join(g), mode, combi_g))
                #     continue
                for v in g:
                    combi_g -= loads_map[mode]["%s" % v]
                print("combi_g: ",combi_g)
                # with open('%s' % log_name, 'a') as file:
                #     file.write("%s, mode: %d, combi_g: %f\n" % ('_'.join(g), mode, combi_g))
                combi_record[mode][i] = combi_g
                # 如果groups_profiling最开始就小于0，是通过减更负的才变正的，直接走; combi_g不算数
                if (groups_profiling[mode][i]<=0):
                    continue
                # 判断当前combi_g是否达到要求，达到后还要跟之前的combi进行比较
                if (combi_g >= HighThes1 and combi_g > combi[i]): # bypass 整个 g
                    combi[i] = combi_g # 更新当前的combi
                    for v in g: # 更新bypass策略
                        policy_map["%s" % v] = mode

                    # with open('%s' % log_name, 'a') as file:
                    #     file.write("%s, mode is %d: combi: %f is chose----\n" % ('_'.join(g), mode, combi_g))

            # 如果g已经确认模式，则不用看单个了，直接走
            if combi[i] != negInfinity: 
                continue
            scores = [negInfinity]*len(g) #记录g的score，初始化为负无穷
            for j in range(len(g)):
                v = g[j]
                for mode in modes:
                    score = loads_map[mode]["%s" % v]
                    if (len(g) != 1 and combi_record[mode][i] < 0): # 不等于1，TODO：combi为正的时候也要加吗
                        # score += weight * combi_record[mode][i]/len(g)
                        score += weight * combi_record[mode][i]
                    print("score of %s, mode is %d: %f" %(v, mode, score))
                    # with open('%s' % log_name, 'a') as file:
                    #     file.write("score of %s, mode is %d: %f\n" % (v, mode, score))
                    if (score >= HighThes3 and score > scores[j]):
                        scores[j] = score # 更新当前的score
                        policy_map["%s" % v] = mode

                        # with open('%s' % log_name, 'a') as file:
                        #     file.write("%s, mode: %d, score: %f is chose----\n" % (v, mode, score))
        print(policy_map)

        ## TODO: 得到store的bypass策略
        storebypass, storemode = gloabal_store_bypass_algotithm()

        ## design_policy time
        strSearch, strMode = getPassEnvironFromMap(policy_map)
        time, speedup, offp = offline_profiling(strSearch, strMode, storebypass, storemode, baseline_time)
        with open('%s' % log_name, 'a') as file:
            file.write("weight:%f, %s, mode: %s,\n baseline_time:%f, design_time:%f, offp: %f, speedup: %f\n------\n" % (weight, strSearch, strMode, baseline_time, time, offp, speedup))



def gloabal_store_bypass_algotithm():
    modes = [0,1]
    NONTEMPORAL = 0
    VOLATILE = 1
    strSearch = ""
    strMode = ""
    storebypass = "false"
    storemode = 0

    store_score = negInfinity
    # with open('%s' % log_name, 'a') as file:
    #     file.write("store bypass policy -----------\n")
    for mode in modes:
        time, speedup, offp = offline_profiling(strSearch, strMode, "true", mode, baseline_time)      
        # with open('%s' % log_name, 'a') as file:
        #     file.write("%s, mode: %s, baseline_time:%f, store_time:%f, offp: %f, speedup: %f\n" % ("store_group", mode, baseline_time, time, offp, speedup))
        if (offp > HighThes2 and offp > store_score):
            store_score = offp
            storebypass = "true"
            storemode = mode

    # with open('%s' % log_name, 'a') as file:
    #         file.write("storebypass: %s, storemode: %d\n------\n" % (storebypass, storemode))
    return storebypass, storemode


for kernel in kernel_name:
    print(kernel,"----------------------")
    with open('%s' % log_name, 'a') as file:
        file.write("\n\n------------------------------ kernel_name: %s ------------------------------\n" % (kernel))
    # 初始化该kernel的相关信息----------------------------------------
    os.environ['KERNEL'] = kernel
    # TODO: baseline_pfofiling and output
    baseline_time = baseline_profiling() 
    ## 得到该groups (algorithm 1) 和 所有的单个load
    groups, loads = read_input(kernel)

    ## 得到loads的bypass策略
    global_loads_bypass_algorithm(groups, loads)

    # ## TODO: 得到store的bypass策略
    # storebypass, storemode = gloabal_store_bypass_algotithm()

    # ## design_policy time
    # strSearch, strMode = getPassEnvironFromMap(bypass_policy)
    # time, speedup, offp = offline_profiling(strSearch, strMode, storebypass, storemode, baseline_time)
    # with open('%s' % log_name, 'a') as file:
    #     file.write("%s, mode: %s,\n baseline_time:%f, design_time:%f, offp: %f, speedup: %f\n------\n" % (strSearch, strMode, baseline_time, time, offp, speedup))
