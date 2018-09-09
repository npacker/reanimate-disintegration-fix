Scriptname NEP_DeadThrallTargetCheckScript extends ActiveMagicEffect
{Script attached to Dead Thrall target check effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Faction Property NEP_ReanimateFixDeadThrallFaction Auto
{Faction for all NPCs under influence of Dead Thrall effects.}

Spell Property NEP_ReanimateFixTargetCheckSpell Auto
{Ability that applies the condition-checked effect script to the target.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Debug.Notification("Tracking Dead Thrall.")
  Target.AddToFaction(NEP_ReanimateFixDeadThrallFaction)
  Target.AddSpell(NEP_ReanimateFixTargetCheckSpell)
  Self.Dispel()

EndEvent
