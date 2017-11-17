Scriptname NEP_ReanimateGetTargetScript extends ActiveMagicEffect
{Script to get the target of a reanimate spell.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

NEP_ReanimateTrackTargetScript Property NEP_ReanimatePersistQuest Auto
{The zombie tracking script.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  NEP_ReanimatePersistQuest.CurrentReanimateTarget = Target

  Debug.Trace("Reanimate target: " + Target)

EndEvent
