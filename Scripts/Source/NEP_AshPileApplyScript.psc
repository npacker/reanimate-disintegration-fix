Scriptname NEP_AshPileApplyScript extends ActiveMagicEffect
{Script to apply the reanimate ash pile spell.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Spell Property NEP_ReanimatePersistAshPileSpell Auto
{The reanimate ash pile spell, which applies the responsible effect script.}

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Debug.Trace("NEP_AshPileApplyScript: OnEffectStart")
  Debug.Trace("NEP_AshPileApplyScript: Target is " + Target)
  Target.AddSpell(NEP_ReanimatePersistAshPileSpell)
  Debug.Trace("NEP_AshPileApplyScript: Target has NEP_ReanimatePersistAshPileSpell " + Target.HasSpell(NEP_ReanimatePersistAshPileSpell))

EndEvent
