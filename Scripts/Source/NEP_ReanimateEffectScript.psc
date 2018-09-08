Scriptname NEP_ReanimateEffectScript extends ActiveMagicEffect
{Script attached to Reanimate Fix Effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Spell Property NEP_ReanimateFixTargetCheckSpell Auto
{Ability that applies the condition-checked effect script to the target.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------


Event OnEffectStart(Actor Target, Actor Caster)

  Target.AddSpell(NEP_ReanimateFixTargetCheckSpell)

EndEvent
