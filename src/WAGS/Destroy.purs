module WAGS.Destroy where

import Prelude

import Control.Monad.State (modify_)
import Data.Map as M
import Data.Typelevel.Bool (False)
import WAGS.Control.Types (FrameT(..))
import WAGS.Rendered (Instruction(..))
import WAGS.Universe.AudioUnit as AU
import WAGS.Universe.AudioUnit (class GetPointer, AudioUnitRef(..))
import WAGS.Universe.Bin (class BinEq, class BinToInt, Ptr, PtrListCons)
import WAGS.Universe.EdgeProfile (ManyEdges, NoEdge, SingleEdge)
import WAGS.Universe.Graph (class GraphToNodeList)
import WAGS.Universe.Node (class GetAudioUnit, Node, NodeC, NodeList, NodeListCons, NodeListNil)
import WAGS.Universe.Universe (Universe, UniverseC)
import WAGS.Util (class Gate)
import WAGS.Validation (class PtrNotInPtrList)

class PointerNotConnected (ptr :: Ptr) (i :: Node)

instance pointerNotConnected_NE_Allpass :: PointerNotConnected ptr (NodeC (AU.TAllpass x) NoEdge)

instance pointerNotConnected_SE_Allpass :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TAllpass x) (SingleEdge y))
instance pointerNotConnected_NE_Bandpass :: PointerNotConnected ptr (NodeC (AU.TBandpass x) NoEdge)

instance pointerNotConnected_SE_Bandpass :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TBandpass x) (SingleEdge y))
instance pointerNotConnectedConstant :: PointerNotConnected ptr (NodeC (AU.TConstant x) NoEdge)

instance pointerNotConnected_NE_Convolver :: PointerNotConnected ptr (NodeC (AU.TConvolver x) NoEdge)

instance pointerNotConnected_SE_Convolver :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TConvolver x) (SingleEdge y))
instance pointerNotConnected_NE_Delay :: PointerNotConnected ptr (NodeC (AU.TDelay x) NoEdge)

instance pointerNotConnected_SE_Delay :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TDelay x) (SingleEdge y))

instance pointerNotConnected_NE_DynamicsCompressor :: PointerNotConnected ptr (NodeC (AU.TDynamicsCompressor x) NoEdge)

instance pointerNotConnected_SE_DynamicsCompressor :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TDynamicsCompressor x) (SingleEdge y))
instance pointerNotConnected_NE_Gain :: PointerNotConnected ptr (NodeC (AU.TGain x) NoEdge)

instance pointerNotConnected_SE_Gain :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TGain x) (SingleEdge y))

instance pointerNotConnected_ME_Gain :: PtrNotInPtrList ptr (PtrListCons y z) => PointerNotConnected ptr (NodeC (AU.TGain x) (ManyEdges y z))
instance pointerNotConnected_NE_Highpass :: PointerNotConnected ptr (NodeC (AU.THighpass x) NoEdge)

instance pointerNotConnected_SE_Highpass :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.THighpass x) (SingleEdge y))
instance pointerNotConnected_NE_Highshelf :: PointerNotConnected ptr (NodeC (AU.THighshelf x) NoEdge)

instance pointerNotConnected_SE_Highshelf :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.THighshelf x) (SingleEdge y))
instance pointerNotConnectedLoopBuf :: PointerNotConnected ptr (NodeC (AU.TLoopBuf x) NoEdge)

instance pointerNotConnected_NE_Lowpass :: PointerNotConnected ptr (NodeC (AU.TLowpass x) NoEdge)

instance pointerNotConnected_SE_Lowpass :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TLowpass x) (SingleEdge y))
instance pointerNotConnected_NE_Lowshelf :: PointerNotConnected ptr (NodeC (AU.TLowshelf x) NoEdge)

instance pointerNotConnected_SE_Lowshelf :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TLowshelf x) (SingleEdge y))
instance pointerNotConnectedMicrophone :: PointerNotConnected ptr (NodeC (AU.TMicrophone x) NoEdge)

instance pointerNotConnected_NE_Notch :: PointerNotConnected ptr (NodeC (AU.TNotch x) NoEdge)

instance pointerNotConnected_SE_Notch :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TNotch x) (SingleEdge y))
instance pointerNotConnected_NE_Peaking :: PointerNotConnected ptr (NodeC (AU.TPeaking x) NoEdge)

instance pointerNotConnected_SE_Peaking :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TPeaking x) (SingleEdge y))
instance pointerNotConnectedPeriodicOsc :: PointerNotConnected ptr (NodeC (AU.TPeriodicOsc x) NoEdge)

instance pointerNotConnectedPlayBuf :: PointerNotConnected ptr (NodeC (AU.TPlayBuf x) NoEdge)

instance pointerNotConnected_NE_Recorder :: PointerNotConnected ptr (NodeC (AU.TRecorder x) NoEdge)

instance pointerNotConnected_SE_Recorder :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TRecorder x) (SingleEdge y))
instance pointerNotConnectedSawtoothOsc :: PointerNotConnected ptr (NodeC (AU.TSawtoothOsc x) NoEdge)

instance pointerNotConnectedSinOsc :: PointerNotConnected ptr (NodeC (AU.TSinOsc x) NoEdge)

instance pointerNotConnected_NE_Speaker :: PointerNotConnected ptr (NodeC (AU.TSpeaker x) NoEdge)

instance pointerNotConnected_SE_Speaker :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TSpeaker x) (SingleEdge y))

instance pointerNotConnected_ME_Speaker :: PtrNotInPtrList ptr (PtrListCons y z) => PointerNotConnected ptr (NodeC (AU.TSpeaker x) (ManyEdges y z))
instance pointerNotConnectedSquareOsc :: PointerNotConnected ptr (NodeC (AU.TSquareOsc x) NoEdge)

instance pointerNotConnected_NE_StereoPanner :: PointerNotConnected ptr (NodeC (AU.TStereoPanner x) NoEdge)

instance pointerNotConnected_SE_StereoPanner :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TStereoPanner x) (SingleEdge y))
instance pointerNotConnectedTriangleOsc :: PointerNotConnected ptr (NodeC (AU.TTriangleOsc x) NoEdge)

instance pointerNotConnected_NE_WaveShaper :: PointerNotConnected ptr (NodeC (AU.TWaveShaper x) NoEdge)

instance pointerNotConnected_SE_WaveShaper :: BinEq ptr y False => PointerNotConnected ptr (NodeC (AU.TWaveShaper x) (SingleEdge y))
-----------------------------------
-----------------------------------
-----------------------------------

class PointerNotConnecteds (ptr :: Ptr) (i :: NodeList)

instance pointerNotConnectedsNil :: PointerNotConnecteds a NodeListNil

instance pointerNotConnectedsCons :: (PointerNotConnected a head, PointerNotConnecteds a tail) => PointerNotConnecteds a (NodeListCons head tail)

class RemovePtrFromNodeList (ptr :: Ptr) (nodeListI :: NodeList) (nodeListO :: NodeList) | ptr nodeListI -> nodeListO

instance removePtrFromNListNil :: RemovePtrFromNodeList ptr NodeListNil NodeListNil

instance removePtrFromNListCons ::
  ( GetAudioUnit head headAu
  , GetPointer headAu headPtr
  , BinEq ptr headPtr tf
  , RemovePtrFromNodeList ptr tail newTail
  , Gate tf newTail (NodeListCons head newTail) o
  ) =>
  RemovePtrFromNodeList ptr (NodeListCons head tail) o

class Destroy (ptr :: Ptr) (i :: Universe) (o :: Universe) | ptr i -> o where
  destroy :: forall env proof m. Monad m => AudioUnitRef ptr -> FrameT env proof m i o Unit

instance destroyer ::
  ( BinToInt ptr
  , GraphToNodeList graphi nodeListI
  , PointerNotConnecteds ptr nodeListI
  , RemovePtrFromNodeList ptr nodeListI nodeListO
  , GraphToNodeList grapho nodeListO
  ) =>
  Destroy ptr (UniverseC x graphi changeBit skolems) (UniverseC x grapho changeBit skolems) where
  destroy (AudioUnitRef ptrI) =
    FrameT
      $ do
          modify_
            ( \i ->
                i
                  { internalNodes = M.delete ptrI (i.internalNodes)
                  , internalEdges = M.delete ptrI (i.internalEdges)
                  , instructions = i.instructions <> [ Free ptrI, Stop ptrI ]
                  }
            )
