#pragma once

#include "SubPass.hh"


namespace cm {

struct GroupDivisonPass : public SubPass {
  
  std::unordered_map<llvm::Value*, std::vector<std::string>> array_to_instrs;
  char* app_name;
  char* kernel;
  // std::unordered_map<llvm::Value*, std::vector<std::vector<std::string>>> array_to_instrs;

  // bool construct(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
  //   if (llvm::isa<llvm::BranchInst>(&inst)) {
  //     // 新的Branch指令，为每个数组开始一个新的向量
  //     for (auto& pair : array_to_instrs){
  //       // std::vector<std::string> newVect;
  //       // pair.second.push_back(newVect);
  //       pair.second.emplace_back();
  //     }
  //   }
    
  //   else if (llvm::isa<llvm::LoadInst>(&inst)) {
  //     auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
  //     if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
  //       llvm::Value* pointer = load_inst->getPointerOperand();
  //       llvm::Value* object = llvm::getUnderlyingObject(pointer);
  //       // 添加加载指令到数组的当前vector(向最后一个向量中添加字符串)
  //       if (array_to_instrs[object].empty())
  //         array_to_instrs[object].emplace_back();
      
  //       // 取出结果寄存器
  //       std::string str;
  //       llvm::raw_string_ostream rso(str);
  //       inst.print(rso);
  //       size_t pos = str.find('=');
  //       std::string result;
  //       if (pos != std::string::npos)
  //       {
  //           result = str.substr(0, pos);  // 从0到'='位置的子串，注意此时包含了一些额外的空格
  //           result.erase(std::remove(result.begin(), result.end(), ' '), result.end());  // 移除子串中的空格
  //       }
  //       file << result << " ";
        
  //       array_to_instrs[object].back().push_back(result);

  //     }
  //   }
    
  // }

  void construct(llvm::Instruction& inst, llvm::raw_fd_ostream& file) {
    if (llvm::isa<llvm::BranchInst>(&inst)) {
      for (auto& [object, instrs] : array_to_instrs) {
        // file << "Object: " << object << "\n";
        for (auto& inst : instrs) {
          file << inst << " ";
        }
        file << "\n";
      }

      array_to_instrs.clear();
    }

    if (llvm::isa<llvm::LoadInst>(&inst)) {
      auto load_inst = llvm::dyn_cast<llvm::LoadInst>(&inst);
      if (load_inst->getPointerAddressSpace() == 1 || load_inst->getPointerAddressSpace() == 5){
        llvm::Value* pointer = load_inst->getPointerOperand();
        llvm::Value* object = llvm::getUnderlyingObject(pointer);
        // 取出结果寄存器
        std::string str;
        llvm::raw_string_ostream rso(str);
        inst.print(rso);
        // 查找'='符号之前的子串，也就是"%20"
        size_t pos = str.find('=');
        std::string result;
        if (pos != std::string::npos)
        {
            result = str.substr(0, pos);  // 从0到'='位置的子串，注意此时包含了一些额外的空格
            result.erase(std::remove(result.begin(), result.end(), ' '), result.end());  // 移除子串中的空格
        }
        // std::cout << "Result: " << result << "\n";  // 输出 "%20"
        // file << result << " ";

        // 添加加载指令到数组的vector
        array_to_instrs[object].push_back(result);

        
      }
    }
    
  }

  void runSubPass(llvm::Function& F) override {
    // int fd = open("/workspace/Inst-level-cache-management/system/group/groupDivisonPass.log", O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
    // if (fd == -1) {
    //     llvm::errs() << "Error opening file\n";
    //     return;
    // }
    // llvm::raw_fd_ostream file(fd, /*shouldClose=*/true);

    array_to_instrs.clear();  // 清空 map

    if (F.isDefinitionExact() && F.getCallingConv() == llvm::CallingConv::AMDGPU_KERNEL) {
      // kernel = std::getenv("KERNEL");
      // file << "F.getName():" << F.getName() << "\n";
      // if (F.getName() == kernel){
        
        app_name = std::getenv("APP_NAME");
        std::string result_name = "/workspace/Inst-level-cache-management/system/group/" + std::string(app_name) +"/" + F.getName().str() + ".txt";
        std::cout << result_name << std::endl;
        int fd = open(result_name.c_str(), O_WRONLY | O_CREAT | O_APPEND, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
        if (fd == -1) {
            llvm::errs() << "Error opening file\n";
            return;
        }
        llvm::raw_fd_ostream file(fd, /*shouldClose=*/true);

        file << "F.getName():" << F.getName() << "\n";
        std::cout << "Function name: " << F.getName().str() << std::endl;
        for (auto& BB : F) {
          for (auto& Inst : BB) {
            construct(Inst, file);
          }
        }

        for (auto& [object, instrs] : array_to_instrs) {
          // file << "Object: " << object << "\n";
          for (auto& inst : instrs) {
            file << inst << " ";
          }
          file << "\n";
        }
      // }

    }

    // for (auto& [object, instrs] : array_to_instrs) {
    //   file << "Object: " << object << "\n";
    //   for (auto& inst : instrs) {
    //     file << " - Load instruction: " << inst << "\n";
    //   }
    // }
    

    // for (const auto& pair : array_to_instrs) {
    //   // file << "Object:" << pair.first << "\n";
    //   for (const auto& vec : pair.second) {
    //       if (!vec.empty()) { // 检查向量是否为空
    //         for (const auto& str : vec) {
    //             file << str << ", "; // 打印向量中的每个字符串
    //         }
    //         file << "\n";
    //       }
    //   }
    // }


  } 
};

} // namespace cm
