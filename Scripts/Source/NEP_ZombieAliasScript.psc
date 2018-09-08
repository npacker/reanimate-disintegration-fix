Scriptname NEP_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

EffectShader Property ReanimateFXShader Auto
{Reanimate visual effects, applied to the reanimated actor.}

Faction Property NEP_ReanimateFixDeadThrallFaction Auto
{Faction for zombies affected by Dead Thrall reanimate effects.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fDelay = 2.0

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function CleanUpZombie(Actor Zombie)

  Self.Clear()

  ; If Zombie.Is3DLoaded()
    ; ReanimateFXShader.Stop(Zombie)
  ; EndIf

  Zombie.RemoveFromFaction(NEP_ReanimateFixDeadThrallFaction)

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnLoad()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  ; ReanimateFXShader.Play(Zombie)

EndEvent

Event OnUnload()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  If Zombie.IsDisabled() || Zombie.IsDeleted()
    Zombie.Kill()
  Else
    RegisterForSingleUpdate(fDelay)
  EndIf

EndEvent

Event OnCellDetach()

  RegisterForSingleUpdate(fDelay)

EndEvent

Event OnUpdate()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  If Zombie.IsDead()
    CleanUpZombie(Zombie)
  EndIf

EndEvent

Event OnDying(Actor Killer)

  CleanUpZombie(Self.GetReference() as Actor)

EndEvent

Event OnDeath(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  CleanUpZombie(Zombie)

EndEvent
