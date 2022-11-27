//===-- Frequent Path Loop Invariant Code Motion Pass ------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// EECS583 F22 - This pass can be used as a template for your Frequent Path LICM
//               homework assignment. The pass gets registered as "fplicm".
//
// This pass performs loop invariant code motion, attempting to remove as much
// code from the body of a loop as possible.  It does this by either hoisting
// code into the preheader block, or by sinking code to the exit blocks if it is
// safe. 
//
////===----------------------------------------------------------------------===//
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/LoopIterator.h"
#include "llvm/Analysis/LoopPass.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Scalar/LoopPassManager.h"
#include "llvm/Transforms/Utils/BasicBlockUtils.h"
#include "llvm/Transforms/Utils/LoopUtils.h"
#include "llvm/Analysis/BranchProbabilityInfo.h"
#include "llvm/Analysis/BlockFrequencyInfo.h"

#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/LoopNestAnalysis.h"
#include "llvm/Transforms/Scalar/LoopUnrollPass.h"
#include "llvm/Transforms/Utils/UnrollLoop.h"
#include "llvm/IR/Metadata.h"
/* *******Implementation Starts Here******* */
#include <set>
#include <string>
#include <cmath>
#include <unordered_map>
/* *******Implementation Ends Here******* */

using namespace llvm;

#define DEBUG_TYPE "fplicm"


namespace Correctness{
struct FPLICMPass : public LoopPass {
  static char ID;
  bool found_target = false;
  FPLICMPass() : LoopPass(ID) {}

  void printInstruction(Instruction* instr) {
    errs() << instr->getOpcodeName() << " ";
    for (uint32_t i = 0; i < instr->getNumOperands(); i++) {
      errs() << instr->getOperand(i)->getName().data() << " ";
    }
    errs() << "\n";
  }

  bool runOnLoop(Loop *L, LPPassManager &LPM) override {
    bool Changed = false;

    /* *******Implementation Starts Here******* */
    // Determine if target loop 
    LLVMContext c = LLVMContext();
    ScalarEvolution *SE = &getAnalysis<ScalarEvolutionWrapperPass>().getSE();
    LoopNest ln = LoopNest(*L, *SE);
    unsigned int depth = ln.getNestDepth();

    if (!found_target && depth == 1) {
      found_target = true;

      // Setup (Code below taken from setLoopAlreadyUnrolled)
      SmallVector<Metadata *, 32> ops;
      LLVMContext &Context = L->getHeader()->getContext();

      // Create new llvm.loop.disable_nonforced metadata
      MDNode *disable_nonforced = MDNode::get(Context, MDString::get(Context, "llvm.loop.disable_nonforced"));
      MDNode *LoopID = L->getLoopID();
      MDNode *NewLoopID = makePostTransformationMetadata(Context, LoopID, {}, {disable_nonforced});
      L->setLoopID(NewLoopID);

      // Create new llvm.loop.unroll.count metadata
      MDNode *UnrollCountMD = MDNode::get(Context, MDString::get(Context, "llvm.loop.unroll.count"));
      Type *I32Ty = Type::getInt32Ty(Context);
      Constant *Two = ConstantInt::get(I32Ty, 4);
      ops.push_back(MDString::get(Context, "llvm.loop.unroll.count"));
      ops.push_back(ValueAsMetadata::getConstant(Two));
      MDNode *nodes = MDNode::get(Context, ops);
      
      LoopID = L->getLoopID();
      NewLoopID = makePostTransformationMetadata(Context, LoopID, {"llvm.loop.unroll."}, {nodes});
      L->setLoopID(NewLoopID);

      // Check metadata insertion
      MDNode *MD_unroll_count = GetUnrollMetadata(L->getLoopID(), "llvm.loop.unroll.count");
      if (MD_unroll_count)
        errs() << "Found unroll count metadata\n";
      else
        errs() << "Did not find unroll count metadata\n";

      MDNode *MD_nonforced = GetUnrollMetadata(L->getLoopID(), "llvm.loop.disable_nonforced");
      if (MD_nonforced)
        errs() << "Found nonforced metadata\n";
      else
        errs() << "Did not find nonforced metadata\n";

      Changed = true;
    }
    else {
      // Set disable_nonforced for all loops
      LLVMContext &Context = L->getHeader()->getContext();

      // Create new llvm.loop.disable_nonforced metadata
      MDNode *disable_nonforced = MDNode::get(Context, MDString::get(Context, "llvm.loop.disable_nonforced"));
      MDNode *LoopID = L->getLoopID();
      MDNode *NewLoopID = makePostTransformationMetadata(Context, LoopID, {}, {disable_nonforced});
      L->setLoopID(NewLoopID);
    }

    // LoopNest object for this loop
    // if !found_target and nest_depth == 1
      // found target = true
      // Changed = true
      // do stuff 
    /* *******Implementation Ends Here******* */
    
    return Changed;
  }


  void getAnalysisUsage(AnalysisUsage &AU) const override {
    // AU.addRequired<BranchProbabilityInfoWrapperPass>();
    // AU.addRequired<BlockFrequencyInfoWrapperPass>();
    // AU.addRequired<LoopInfoWrapperPass>();
    AU.addRequired<ScalarEvolutionWrapperPass>();
  }

private:
  /// Little predicate that returns true if the specified basic block is in
  /// a subloop of the current one, not the current one itself.
  bool inSubLoop(BasicBlock *BB, Loop *CurLoop, LoopInfo *LI) {
    assert(CurLoop->contains(BB) && "Only valid if BB is IN the loop");
    return LI->getLoopFor(BB) != CurLoop;
  }

};
} // end of namespace Correctness

char Correctness::FPLICMPass::ID = 0;
static RegisterPass<Correctness::FPLICMPass> X("force-unroll", "Frequent Loop Invariant Code Motion for correctness test", false, false);
