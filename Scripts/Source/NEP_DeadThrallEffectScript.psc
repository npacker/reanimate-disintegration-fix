Scriptname NEP_DeadThrallEffectScript extends ActiveMagicEffect
{Script attached to Dead Thrall effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{The player.}

Spell Property NEP_ReanimateFixDeadThrallTargetCheckSpell Auto
{Ability that applies the condition-checked effect script to the target.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------


Event OnEffectStart(Actor Target, Actor Caster)

  If Caster == PlayerRef
    Utility.Wait(6.1)
    Target.AddSpell(NEP_ReanimateFixDeadThrallTargetCheckSpell)
  EndIf

  Self.Dispel()

EndEvent
