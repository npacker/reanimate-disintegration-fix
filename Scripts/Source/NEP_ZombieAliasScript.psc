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

  Debug.Trace("Cleaned up zombie: " + Zombie)

EndFunction

Function MoveZombieToPlayer(Actor Zombie)

  Cell ZombieCell = Zombie.GetParentCell()
  Cell PlayerCell = PlayerRef.GetParentCell()

  If ZombieCell != PlayerCell \
      && !(!ZombieCell.IsInterior() && !PlayerCell.IsInterior())
    float XOffset = Math.Sin(PlayerRef.GetAngleZ()) * fOffsetDistance
    float YOffset = Math.Cos(PlayerRef.GetAngleZ()) * fOffsetDistance
    float ZOffset = 0.0

    Zombie.MoveTo(PlayerRef, XOffset, YOffset, ZOffset, True)
    UnregisterForUpdate()
  EndIf

  Debug.Trace("Moved Zombie to player: " + Zombie)

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

  Debug.Trace("Loaded zombie: " + Zombie)

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

  Debug.Trace("Unloaded zombie: " + Zombie)

EndEvent

Event OnCellDetach()

  RegisterForSingleUpdate(fDelay)

  Debug.Trace("Detached cell containing zombie: " + Self.GetReference() as Actor)

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

  Debug.Trace("Updated zombie: " + Zombie)

EndEvent

Event OnDying(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  CleanUpZombie(Zombie)

  Debug.Trace("Zombie is dying: " + Zombie)

EndEvent

Event OnDeath(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  CleanUpZombie(Zombie)

  Debug.Trace("Zombie is dead: " + Zombie)

EndEvent
