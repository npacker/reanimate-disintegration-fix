Scriptname NEP_ReanimateEffectScript extends ActiveMagicEffect
{Script attached to Reanimate Fix Effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Actor Property PlayerRef Auto
{The player.}

Spell Property NEP_ReanimateFixTargetCheckSpell Auto
{Ability that applies the condition-checked effect script to the target.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------


Event OnEffectStart(Actor Target, Actor Caster)

  If Caster == PlayerRef
    Utility.Wait(6.1)
    Target.AddSpell(NEP_ReanimateFixTargetCheckSpell)
  EndIf

  Self.Dispel()

EndEvent
