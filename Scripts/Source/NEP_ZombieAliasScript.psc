Scriptname NEP_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Spell Property NEP_ReanimatePersistAshPileSpell Auto
{The reanimate ash pile spell, which applies the responsible effect script.}

Spell Property NEP_ReanimatePersistFortifyHealingSpell Auto
{Spell that applies the fortify healing rate spell to dead thralls.}

Spell Property PerkDarkSoulsZombieBonus Auto
{Dark Souls spell, boosts zombie health, included so that it can be re-applied.}

Perk Property DarkSouls Auto
{Dark Souls perk, included so that if the player has the perk the effect can be re-applied.}

FormList Property NEP_DeadThrallList Auto
{Dead thrall tracking form list.}

EffectShader Property ReanimateFXShader Auto
{Reanimate visual effects, applied to the reanimated actor.}

Actor Property PlayerRef Auto
{The player.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fOffsetDistance = 100.0

Float fDelay = 2.0

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function CleanUpZombie(Actor Zombie)

  Self.Clear()

  If Zombie.Is3DLoaded()
    ReanimateFXShader.Stop(Zombie)
  EndIf

  If NEP_DeadThrallList.HasForm(Zombie)
    NEP_DeadThrallList.RemoveAddedForm(Zombie)
  EndIf

EndFunction

Function MoveZombieToPlayer(Actor Zombie)

  If Zombie.GetParentCell() != PlayerRef.GetParentCell()
    Zombie.MoveTo(PlayerRef, \
      Math.Sin(PlayerRef.GetAngleZ()) * fOffsetDistance, \
      Math.Cos(PlayerRef.GetAngleZ()) * fOffsetDistance, \
      0.0, True)
    UnregisterForUpdate()
  EndIf

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

  If NEP_DeadThrallList.HasForm(Zombie)
    Zombie.AddSpell(NEP_ReanimatePersistFortifyHealingSpell)
  Else
    Zombie.AddSpell(NEP_ReanimatePersistAshPileSpell)
  EndIf

  If PlayerRef.HasPerk(DarkSouls)
    Zombie.AddSpell(PerkDarkSoulsZombieBonus)
  EndIf

  ReanimateFXShader.Play(Zombie)

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
  Else
    MoveZombieToPlayer(Zombie)
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
