module WAGS.Example.KitchenSink.TLP.Highpass where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Math ((%))
import WAGS.Change (change)
import WAGS.Connect (connect)
import WAGS.Control.Functions (branch, env, inSitu, proof, withProof)
import WAGS.Control.Qualified as WAGS
import WAGS.Control.Types (Frame, Scene)
import WAGS.Create (create)
import WAGS.Cursor (cursor)
import WAGS.Destroy (destroy)
import WAGS.Disconnect (disconnect)
import WAGS.Example.KitchenSink.TLP.LoopSig (LoopSig)
import WAGS.Example.KitchenSink.TLP.Microphone (doMicrophone)
import WAGS.Example.KitchenSink.Timing (ksHighpassIntegral, pieceTime)
import WAGS.Example.KitchenSink.Types.Empty (reset)
import WAGS.Example.KitchenSink.Types.Highpass (HighpassUniverse, ksHighpassHighpass, ksHighpassGain, ksHighpassPlaybuf, deltaKsHighpass)
import WAGS.Graph.Optionals (microphone)
import WAGS.Interpret (FFIAudio)
import WAGS.Run (SceneI)

doHighpass ::
  forall proofA iu cb.
  Frame (SceneI Unit Unit) FFIAudio (Effect Unit) proofA iu (HighpassUniverse cb) LoopSig ->
  Scene (SceneI Unit Unit) FFIAudio (Effect Unit) proofA
doHighpass =
  branch \lsig -> WAGS.do
    { time } <- env
    toRemove <- cursor ksHighpassHighpass
    toRemoveBuf <- cursor ksHighpassPlaybuf
    gn <- cursor ksHighpassGain
    pr <- proof
    withProof pr
      $ if time % pieceTime < ksHighpassIntegral then
          Right (change (deltaKsHighpass time) $> lsig)
        else
          Left
            $ inSitu doMicrophone WAGS.do
                disconnect toRemoveBuf toRemove
                disconnect toRemove gn
                destroy toRemove
                destroy toRemoveBuf
                reset
                toAdd <- create microphone
                connect toAdd gn
                withProof pr lsig
