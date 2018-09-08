Scriptname NEP_ReanimateSignalScript extends ActiveMagicEffect
{Script that signals when a successful reanimation occurs.}

NEP_ReanimateTrackTargetScript Property NEP_ReanimatePersistQuest Auto

Event OnEffectStart(Actor Target, Actor Caster)

  While NEP_ReanimatePersistQuest.CurrentReanimateTarget == None
    Utility.Wait(0.001)
  EndWhile

  Debug.Trace("Signalling reanimate cast.")

  NEP_ReanimatePersistQuest.TrackZombie()

EndEvent
