Scriptname NEP_DeadThrallEffectScript extends ActiveMagicEffect
{Script attached to Dead Thrall effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Spell Property NEP_ReanimateFixDeadThrallTargetCheckSpell Auto
{Ability that applies the condition-checked effect script to the target.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------


Event OnEffectStart(Actor Target, Actor Caster)

  Target.AddSpell(NEP_ReanimateFixDeadThrallTargetCheckSpell)

EndEvent