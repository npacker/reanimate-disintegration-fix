Scriptname NEP_ReanimateSignalScript extends ActiveMagicEffect
{Script that signals when a successful reanimation occurs.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateTrackTargetScript Property NEP_ReanimatePersistQuest Auto
{Property holding the most recent target of a reanimate spell.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Utility.Wait(0.001)

  While NEP_ReanimatePersistQuest.CurrentReanimateTarget == None
    Utility.Wait(0.001)
  EndWhile

  Debug.Trace("Signalling reanimate cast...")

  NEP_ReanimatePersistQuest.TrackZombie(NEP_ReanimatePersistQuest.CurrentReanimateTarget)

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  Debug.Trace("Signalled reanimate cast...")
  Debug.Trace("Target of reanimate effect: " + Target)

EndEvent
