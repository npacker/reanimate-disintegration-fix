Scriptname NEP_DeadThrallTargetCheckScript extends ActiveMagicEffect
{Script attached to Dead Thrall target check effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Faction Property NEP_ReanimateFixDeadThrallFaction Auto
{Faction for all NPCs under influence of Dead Thrall effects.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Target.AddToFaction(NEP_ReanimateFixDeadThrallFaction)

EndEvent

Event OnEffectFinish(Actor Target, Actor Caster)

  Target.RemoveFromFaction(NEP_ReanimateFixDeadThrallFaction)

EndEvent
