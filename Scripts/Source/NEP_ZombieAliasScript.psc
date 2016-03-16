Scriptname NEP_ZombieAliasScript extends ReferenceAlias
{Script attached to aliases on the reanimated thralls tracking quest.}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

Spell Property NEP_ReanimatePersistAshPileSpell Auto
{Spell that applies the reanimate ash pile effect.}

Spell Property NEP_ReanimatePersistFortifyHealingSpell Auto
{Spell that applies the fortify healing rate spell to dead thralls.}

Spell Property DeadThrall Auto
{Dead Thrall spell, included so that it can be removed from the player when a thrall dies.}

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
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function MoveZombieToPlayer(Actor Zombie)

  If Zombie.GetParentCell() != PlayerRef.GetParentCell()
    Zombie.MoveTo(PlayerRef)
    UnregisterForUpdate()
  EndIf

EndFunction

Function PathZombieToPlayer(Actor Zombie)

  If Zombie.GetParentCell() == PlayerRef.GetParentCell()
    Zombie.PathToReference(PlayerRef, 1)
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
  PathZombieToPlayer(Zombie)

EndEvent

Event OnCellDetach()

  RegisterForSingleUpdate(5.0)

EndEvent

Event OnUpdate()

  Actor Zombie = Self.GetReference() as Actor

  If Zombie == None
    Return
  EndIf

  MoveZombieToPlayer(Zombie)

EndEvent

Event OnDying(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  Self.Clear()

  If Zombie.Is3DLoaded()
    ReanimateFXShader.Stop(Zombie)
  EndIf

  If NEP_DeadThrallList.HasForm(Zombie)
    NEP_DeadThrallList.RemoveAddedForm(Zombie)
  EndIf

EndEvent
