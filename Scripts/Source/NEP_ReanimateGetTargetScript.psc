Scriptname NEP_ReanimateGetTargetScript extends ActiveMagicEffect
{Script to get the target of a reanimate spell.}

NEP_ReanimateTrackTargetScript Property NEP_ReanimatePersistQuest Auto

Event OnEffectStart(Actor Target, Actor Caster)

  NEP_ReanimatePersistQuest.CurrentReanimateTarget = Target

  Debug.Trace("Got current reanimate target: " + Target)

EndEvent
