import os
import subprocess
import re

'''
 获取NONTEMPORAL和VOLATILE每个模式下的最优解
 Pass: InjectPass_profiling
'''

'''
 injectOffiling.pass
 现有env:
 APP_NAME
 SOURCE_CPP
 BYPASS_ENABLE
 IR_ENABLE
 INJECT_BIT
 SEARCH
 KERNEL
 STOREBYPASS
 VOLATILE
 NONTEMPORAL
'''

'''
首先获取划分:修改pass为 GroupDivisonPass
bash scripts/gen_binary.sh 
修改pass为 InjectPass_profiling
python3 system/instruction_level_control.py
'''
# 获取该APP的信息
app_name = "hfuse_dct8x8_hip"
kernel_name = ["_Z21Fused_DCT_IDCT_kernelPfPKfjjjS_S1_jjjj"] # 考虑一个应用有多个kernel
os.environ['SOURCE_CPP'] = "OFF"
# baseline_time = 4.3448



## env相关信息
os.environ['APP_NAME'] = app_name


HighThes1 = 1.5 # group theshold
LowThes1 = -20 # group lowtheshold
HighThes2 = 0.1 # store theshold
HighThes3 = 1 # load theshold
pattern = "(.*) [mu]s"
iteration = 1 # 运行次数
log_name = "./system/result/%s.txt" % app_name
input_name_pre = "./system/group/%s/" % app_name
# mode：nontemporal，valotale
# print("baseline_time: ", baseline_time)
# with open('%s' % log_name, 'a') as file:
#     file.write("baseline_time: %f\n" % baseline_time)

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

# algorithm 2
# profiling 放在另一个文件实现
def offline_profiling(g, baseline_time):
    str_g = ','.join(g)
    print("search: %s" % str_g )
    os.environ['SEARCH'] = str_g
    inject_bit = '_'.join([i[1:] for i in g])
    if len(g) > 20:
        inject_bit = "long_goups_%d" % (len(g))
    print("inject_bit: %s" % inject_bit )
    os.environ['INJECT_BIT'] = inject_bit
    # 编译--------------------------------------
    os.environ['BYPASS_ENABLE'] = "ON"
    os.environ['IR_ENABLE'] = "OFF"
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
    return time, improve

def baseline_profiling():
    with open('%s' % log_name, 'a') as file:
        file.write("baseline_profiling #####\n")
    inject_bit = "cache"
    os.environ['INJECT_BIT'] = inject_bit
    os.environ['BYPASS_ENABLE'] = "OFF"
    os.environ['IR_ENABLE'] = "ON"
    os.environ['STOREBYPASS'] = "false"
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

    with open('%s' % log_name, 'a') as file:
        file.write("baseline_time: %f\n" % time)

    return time


def global_loads_bypass_algorithm(mode, groups, loads):
    with open('%s' % log_name, 'a') as file:
        file.write("------------------- mode: %s ------------------\n" % ("VOLATILE" if mode == 1 else "NONTEMPORAL" ))

    total_score = 0.0
    policy = [] # 一维列表
    combi = []
    if (mode == 0): # NONTEMPORAL
        os.environ['VOLATILE'] = "false"
        os.environ['NONTEMPORAL'] = "true"
    if (mode == 1): # VOLATILE
        os.environ['VOLATILE'] = "true"
        os.environ['NONTEMPORAL'] = "true"
    os.environ['STOREBYPASS'] = "false"

    groups_pofiling = [] # 每个group对应的profiling
    loads_map = {} # map，key：每个load，value：对应的profiling
    # groups_map = {} # map，key：每个group，value：对应的profiling
    # 首先进行 offline profiling--------------------------------------
    # baseline_time = baseline_profiling()
    with open('%s' % log_name, 'a') as file:
        file.write("offline_profiling #######\n")
    worse_loads = []
    for g in groups:
        # g为列表，可能一或多个元素
        print("offline_profiling:",g)
        _, offp = offline_profiling(g, baseline_time)
        groups_pofiling.append(offp)
        # 将 offline_profilling 小于 LowThes or 其他一定数值里的load 不进行profiling，从而节省时间
        if (offp <= LowThes1):
            worse_loads.extend(g)
        if len(g) == 1:
            loads_map["%s" % g[0]] = offp

        with open('%s' % log_name, 'a') as file:
            file.write("%s: %f\n" % ('_'.join(g), offp))
    for g in loads:
        if (g[0] in loads_map.keys()):
            continue
        if (g[0] in worse_loads): # 小于LowThes不会再去看单个了, 不进行profiling，从而节省时间
            continue
        print("offline_profiling:",g)
        print("%s in loads but not in goups" % g[0])
        _, offp = offline_profiling(g, baseline_time)
        loads_map["%s" % g[0]] = offp

        with open('%s' % log_name, 'a') as file:
            file.write("%s: %f\n" % ('_'.join(g), offp))
    # print(groups_pofiling)
    # print(loads_map)
   
    with open('%s' % log_name, 'a') as file:
        file.write("algorithm2 #####\n")
    
    for i in range(len(groups)):
        g = groups[i]
        print("algorithm2:",g,"-------------")
        combi_g = groups_pofiling[i]
        if (combi_g <= LowThes1): # 如果combi_g真的太大影响了，单个都不看了，直接走
            with open('%s' % log_name, 'a') as file:
                file.write("combi_g(groups_profiling) of %s: %f\n" % ('_'.join(g), combi_g))
            continue

        for v in g:
            combi_g -= loads_map["%s" % v]
        combi.append(combi_g)
        print("combi_g: ",combi_g)
        with open('%s' % log_name, 'a') as file:
            file.write("combi_g of %s: %f\n" % ('_'.join(g), combi_g))

        if (combi_g >= HighThes1): # bypass 整个 g
            total_score += combi_g
            policy.extend(g)
        # elif (combi_g <= LowThes1): # 如果combi_g真的太大影响了，单个都不看了，直接走
        #     continue
        else:
            for v in g:
                # score = loads_map["%s" % v] + combi_g/len(g) 不在这里看combi_g在单个score的影响
                score = loads_map["%s" % v] # weight = 0
                print("score of %s: %f" %(v, score))
                with open('%s' % log_name, 'a') as file:
                    file.write("score of %s: %f\n" % (v, score))

                if (score >= HighThes3):
                    total_score += score
                    policy.append(v)
    print("mode: %s"  % ("VOLATILE" if mode == 1 else "NONTEMPORAL" ))
    print(policy)
    print(total_score)
    with open('%s' % log_name, 'a') as file:
        file.write("mode is %s\n" % ("VOLATILE" if mode == 1 else "NONTEMPORAL" ))
    with open('%s' % log_name, 'a') as file:
        file.write("policy is %s, total score is %f\n" % ('_'.join(policy), total_score))
    with open('%s' % log_name, 'a') as file:
        file.write("------------------- mode: %s ------------------\n" % ("VOLATILE" if mode == 1 else "NONTEMPORAL" ))

    return policy, total_score


def gloabal_store_bypass_algotithm(mode):
    with open('%s' % log_name, 'a') as file:
        file.write("store_bypass_profiling #####\n")
    if (mode == 0): # NONTEMPORAL
        os.environ['VOLATILE'] = "false"
        os.environ['NONTEMPORAL'] = "true"
    if (mode == 1): # VOLATILE
        os.environ['VOLATILE'] = "true"
        os.environ['NONTEMPORAL'] = "true"
    os.environ['STOREBYPASS'] = "true"

    # 编译--------------------------------------
    inject_bit = "store_bypass"
    os.environ['INJECT_BIT'] = inject_bit
    os.environ['BYPASS_ENABLE'] = "ON"
    os.environ['IR_ENABLE'] = "OFF"
    os.environ['SEARCH'] = ""
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
    with open('%s' % log_name, 'a') as file:
        file.write("store_bypass improve: %f \n" % improve)
    return improve 

for kernel in kernel_name:
    print(kernel,"----------------------")
    with open('%s' % log_name, 'a') as file:
        file.write("\n\n------------------------------ kernel_name: %s ------------------------------\n" % (kernel))
    # 初始化该kernel的相关信息----------------------------------------
    os.environ['KERNEL'] = kernel
    ## 得到该groups (algorithm 1) 和 剩余的所有单个load
    groups, loads = read_input(kernel)
    # groups = [["%26"],["%28"],["%31"],["%38"],["%47","%50"],["%61", "%66"],["%74"],["%84"]]
    # loads = [["%26"],["%28"],["%31"],["%38"],["%47"],["%50"],["%61"],["%66"],["%74"],["%84"]]
    # groups_and_loads = [["%26"],["%28"],["%31"],["%38"],["%47"],["%50"],["%61"],["%66"],["%74"],["%84"]]
    # algorim 2: ---------------------------------------------------
    baseline_time = baseline_profiling() 
    modes = [0, 1]
    # modes = [1]
    NONTEMPORAL = 0
    VOLATILE = 1
    # results -----
    policies = []
    scores = []
    store_policies = [] # bool lists
    for mode in modes:
        bypass_policy, total_score = global_loads_bypass_algorithm(mode, groups, loads)
        # score_group bypass policy
        store_score = gloabal_store_bypass_algotithm(mode)
        if (store_score > HighThes2):
            total_score += store_score
            store_policies.append(True)
        else:
            store_policies.append(False)

        policies.append(bypass_policy) 
        scores.append(total_score)
    
    answer = 1
    if (scores[0] > scores[1]):
        answer = 0
    print("answer:%d, %s ------------------------" % (answer, "VOLATILE" if answer==1 else "NONTEMPORAL" ))
    print(policies[answer])
    print("store_policy: ", store_policies[answer])
    print("total_score: %f" % (scores[answer]))
    with open('%s' % log_name, 'a') as file:
        file.write("------------------- answer------------------\n %s \n" % ("VOLATILE" if answer == 1 else "NONTEMPORAL" ))

    # design policy time ---------------------------------------
    ## 设置环境变量
    ## TODO 把mode, store 加入到offline_profiling中，以输入的形式控制
    ## 现在都是在offline_profiling之前进行初始化
    if (answer == 0): # NONTEMPORAL
        os.environ['VOLATILE'] = "false"
        os.environ['NONTEMPORAL'] = "true"
    if (answer == 1): # VOLATILE
        os.environ['VOLATILE'] = "true"
        os.environ['NONTEMPORAL'] = "true"
    # 加入store_bypass相关的环境变量，控制store策略
    if (store_policies[answer]):
        os.environ['STOREBYPASS'] = "true"
    else:
        os.environ['STOREBYPASS'] = "false"
    policy_time, offp = offline_profiling(policies[answer], baseline_time)
    with open('%s' % log_name, 'a') as file:
        file.write("%s, store_bypass is %d:\n baseline_time:%f , time:%f, real improve:%f \n" % ('_'.join(policies[answer]), store_policies[answer], baseline_time, policy_time, offp))
