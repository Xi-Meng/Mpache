#pragma once

#include "SubPass.hh"

namespace cm {

// Directed Acyclic Graph (DAG)
// reference https://blog.csdn.net/weixin_43854617/article/details/127757060
struct DAG {
  // to generate critical edges when enable onlyForLS
  std::map<llvm::Value *, std::vector<llvm::Value *>> edges;
  // edges in the DAG
  std::set<std::pair<llvm::Value *, llvm::Value *>> critcal_edges;
  // nodes in the DAG
  std::set<llvm::Value *> nodes;
  // to generate critical edges when enable onlyForLS
  std::map<llvm::Value *, bool> node_vis;
  // prefix path when storing graph(.dot)
  std::string path_prefix;
  // if true generate DAG only for load/store , else for all insts
  bool onlyForLS;

  DAG(std::string path_prefix, bool onlyForLS) : path_prefix(path_prefix), onlyForLS(onlyForLS) {
  }

  // translate instruction to words
  std::string printValue(llvm::Value *value) {
    std::string temp_str;
    llvm::raw_string_ostream os(temp_str);
    value->print(os);
    // To resolve format error in .dot file
    for (auto& e : temp_str) {
      if (e == '\"') {
        e = '\'';
      } else if (e == '<' || e == '{') {
        e = '(';
      } else if (e == '>' || e == '}') {
        e = ')';
      }
    }
    return temp_str;
  }

  // depth-first search on the edges
  void dfs(llvm::Value *orignNode, llvm::Value *curNode) {
    node_vis[curNode] = true;
    for (auto node : edges[curNode]) {
      if (llvm::dyn_cast<llvm::LoadInst>(node) || llvm::dyn_cast<llvm::StoreInst>(node)) {
        critcal_edges.insert(std::make_pair(orignNode, node));
      } else if (!node_vis[node]) {
        dfs(orignNode, node);
      }
    }
  }

  // generate critical edges from edges
  void genLoadStoreEdges() {
    for (auto node : nodes) {
      node_vis.clear();
      dfs(node, node);
    }
  }

  // store DAG to file(.dot)
  void printDAG(llvm::Function& F) {
    std::error_code error;
    std::string path;
    // if (auto cm_proj_path = getenv("CM_PROJ_PATH")) {
    if (auto cm_proj_path = "/workspace/Inst-level-cache-management") {
      if (onlyForLS) {
        path = (std::string(cm_proj_path) + "/tmp/" + path_prefix + "/" + F.getName() + "_LS.dot").str();
      } else {
        path = (std::string(cm_proj_path) + "/tmp/" + path_prefix + "/" + F.getName() + ".dot").str();
      }
    } else {
      path = (F.getName() + ".dot").str();
      llvm::outs() << "Warn env CM_PROJ_PATH not set!\n";
    }
    llvm::outs() << path_prefix << ' ' << path << "\n";
    llvm::raw_fd_ostream file(path, error);

    file << "digraph \"DAG for'" + F.getName() + "\' function\" {\n";
    // dump node
    for (auto node = nodes.begin(), node_end = nodes.end(); node != node_end; ++node) {
      if (llvm::dyn_cast<llvm::LoadInst>(*node)) {
        file << "\tNode" << *node << "[fontcolor=red, shape=record, label=\"" << printValue(*node) << "\"];\n";
      } else if (llvm::dyn_cast<llvm::StoreInst>(*node)) {
        file << "\tNode" << *node << "[fontcolor=blue, shape=record, label=\"" << printValue(*node) << "\"];\n";
      } else {
        file << "\tNode" << *node << "[shape=record, label=\"" << printValue(*node) << "\"];\n";
      }
    }
    // dump edge of data flow
    file << "edge"
         << "\n";
    for (auto edge = critcal_edges.begin(), edge_end = critcal_edges.end(); edge != edge_end; ++edge) {
      file << "\tNode" << edge->first << " -> Node" << edge->second << "\n";
    }
    file << "}\n";
    file.close();
  }
};

} // namespace cm