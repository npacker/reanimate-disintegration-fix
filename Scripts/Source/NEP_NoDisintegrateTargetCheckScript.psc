Scriptname NEP_NoDisintegrateTargetCheckScript extends NEP_TargetCheckEffectScript
{Script attached to Dead Thrall target check effect.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Faction Property NEP_ReanimateFixNoDisintegrateFaction Auto
{Faction for all zombies that should not disintegrate on death.}

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Target.AddToFaction(NEP_ReanimateFixNoDisintegrateFaction)
  TrackZombie(Target)
  Self.Dispel()

EndEvent
