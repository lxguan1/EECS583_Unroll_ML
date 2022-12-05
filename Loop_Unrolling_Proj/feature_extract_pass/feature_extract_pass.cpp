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
#include "llvm/CodeGen/MachineBasicBlock.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineTraceMetrics.h"
#include "llvm/Analysis/ScalarEvolution.h"
#include "llvm/Analysis/DependenceAnalysis.h"

#include <vector>
#include <algorithm>
#include <iostream>
#include <fstream>

/* *******Implementation Starts Here******* */
// include necessary header files
/* *******Implementation Ends Here******* */

using namespace llvm;

#define DEBUG_TYPE "fplicm"


  struct FeatureExtractionPass : public LoopPass
  {
    static char ID;
    FeatureExtractionPass() : LoopPass(ID) {}

    bool runOnLoop(Loop *L, LPPassManager &LPM) override
    {
      bool Changed = false;

      /* *******Implementation Starts Here******* */
      BlockFrequencyInfo &bfi =
          getAnalysis<BlockFrequencyInfoWrapperPass>().getBFI();
      BranchProbabilityInfo &bpi =
          getAnalysis<BranchProbabilityInfoWrapperPass>().getBPI();
      LoopInfo &LI = getAnalysis<LoopInfoWrapperPass>().getLoopInfo();
      //MachineTraceMetrics &MTM = getAnalysis<MachineFunctionPass>().get
      ScalarEvolution &SE = getAnalysis<ScalarEvolutionWrapperPass>().getSE();
      DependenceInfo &DI = getAnalysis<DependenceAnalysisWrapperPass>().getDI();
      

      // # of operations
      // # of memory operations
      // # of operands
      // Tripcout (-1) if not known
      // Critical path length
      // Live ranges?
      // 

      //Get LoopNest Level
      LoopNest ln = LoopNest(*L, SE);
      unsigned int depth = ln.getNesttDepth();
      
      //int maxMemDepSize = 0;
      //int minMemDepSize = 0;
      
      
      //Get # of operations, # of memory operations, and # of operands:
      int numOperations = 0;
      int numMemoryOps = 0;
      int numOperands = 0;
      bool notInnerLoop = false;
      std::vector<Instruction::MemoryOps> instrVec = {Instruction::Alloca,
          Instruction::Load,
          Instruction::Store,
          Instruction::GetElementPtr,
          Instruction::Fence,
          Instruction::AtomicCmpXchg,
          Instruction::AtomicRMW};
      for (auto *bb : L->getBlocks()) {
        // Ignore SubLoops
        if (inSubLoop(bb, L, &LI)) {
          // Break out of everything, go to next runOnLoop
          notInnerLoop = true;
          return Changed;
        }

        // Loop through the instructions of the basic block
        for (BasicBlock::iterator i = bb->begin(), e = bb->end(); i != e; ++i)
        {
            numOperations++;

            if (std::find(instrVec.begin(), instrVec.end(), i->getOpcode()) != instrVec.end()) {
                numMemoryOps++;
            }

            // if (LoadInst * linst = dyn_cast<LoadInst>(i)) {
            //   for (auto U : linst->getOperand(0)->users())
            //     { // U is of type User*
            //       if (auto I = dyn_cast<StoreInst>(U))
            //       {
            //         FullDependence fDep = FullDependence(dyn_cast<Instruction>(linst), dyn_cast<Instruction>(I), false, 1);
            //         auto distance = fDep.getDistance(1);
            //         if (distance != nullptr) {
            //           errs() << *(SE.getUnsignedRangeMax(distance).getRawData()) << "\n";
            //         }
            //       }
            //     }
            // }

            numOperands += i->getNumOperands();
        }
      }

      //Get Trace Instruction Length
      BasicBlock *currBB = L->getHeader();
      int traceLength = 0;

      // Loop through basic blocks, starting from the header
      // Get the frequent path of the loop.
      while (true)
      {
        bool freq_path = false;

        // Loop through successor blocks
        for (BasicBlock *bb : successors(currBB))
        {
          BranchProbability bprob = bpi.getEdgeProbability(
              &(*currBB), bb);

          // break on backedge
          if (bb == L->getHeader() || traceLength > 200)
          {
            freq_path = false;
            break;
          }
          if ((bprob.getNumerator() * 1.0 / bprob.getDenominator() - 0.8) >= -1e-8) // Floating point comparison
          {
            currBB = bb;
            traceLength += std::distance(bb->begin(), bb->end());
            freq_path = true;
            break;
          }
        }

        // If there are no frequent branches, exit the loop
        if (freq_path == false)
        {
          break;
        }
      }

      //Get TripCount
      unsigned int tripCount = SE.getSmallConstantMaxTripCount(L);
      //Critical Path

      //Live Range

      //Save Results:
      //unsigned LoopId = L->getLoopID()->getMetadataID();
      std::ofstream csv_file;
      csv_file.open("extracted_features.csv", std::ios_base::app);
      csv_file << numOperations << "," << numMemoryOps << "," << numOperands 
      << "," << tripCount << "," << traceLength << "," << depth << "\n";
      csv_file.close();
      
      

      return Changed;
    }

    void getAnalysisUsage(AnalysisUsage &AU) const override
    {
      AU.addRequired<LoopInfoWrapperPass>();
      AU.addRequired<ScalarEvolutionWrapperPass>();
      AU.addRequired<BranchProbabilityInfoWrapperPass>();
      AU.addRequired<BlockFrequencyInfoWrapperPass>();
      AU.addRequired<DependenceAnalysisWrapperPass>();
      //AU.addRequired<MachineFunctionWrapperPass>();
    }

  private:
    /// Little predicate that returns true if the specified basic block is in
    /// a subloop of the current one, not the current one itself.
    bool inSubLoop(BasicBlock *BB, Loop *CurLoop, LoopInfo *LI)
    {
      assert(CurLoop->contains(BB) && "Only valid if BB is IN the loop");
      return LI->getLoopFor(BB) != CurLoop;
    }
  };

char FeatureExtractionPass::ID = 0;
static RegisterPass<FeatureExtractionPass> X("feature_extract_pass", "Feature extraction for machine learning in loop unrolling", false, false);

