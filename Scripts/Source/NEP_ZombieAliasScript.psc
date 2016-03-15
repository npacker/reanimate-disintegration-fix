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

  Debug.Trace("NEP_ZombieAliasScript: " + Zombie + " pathing to Player")

  If !Zombie.PathToReference(PlayerRef, 1) && Zombie.GetParentCell() != PlayerRef.GetParentCell()
    Debug.Trace("NEP_ZombieAliasScript: " + Zombie + " moving to Player")
    Zombie.MoveTo(PlayerRef)
    Debug.Trace("NEP_ZombieAliasScript: " + Zombie + " moved to Player")
  Else
    Debug.Trace("NEP_ZombieAliasScript: " + Zombie + " pathed to Player")
  EndIf

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnCellDetach()

  Debug.Trace("NEP_ZombieAliasScript: OnCellDetach")

EndEvent

Event OnLoad()

  Actor Zombie = Self.GetReference() as Actor

  Debug.Trace("NEP_ZombieAliasScript: OnLoad")

  If Zombie == None
    Debug.Trace("NEP_ZombieAliasScript: Zombie " + Zombie + " is None")
    Return
  EndIf

  If !NEP_DeadThrallList.HasForm(Zombie)
    Debug.Trace("NEP_ZombieAliasScript: Zombie " + Zombie + " is not a thrall")
    Zombie.AddSpell(NEP_ReanimatePersistAshPileSpell)
    Debug.Trace("NEP_ZombieAliasScript: Zombe " + Zombie + " has NEP_ReanimatePersistAshPileSpell " + Zombie.HasSpell(NEP_ReanimatePersistAshPileSpell))
  Else
    Debug.Trace("NEP_ZombieAliasScript: Zombie " + Zombie + " is a thrall")
    Zombie.AddSpell(NEP_ReanimatePersistFortifyHealingSpell)
    Debug.Trace("NEP_ZombieAliasScript: Zombe " + Zombie + " has NEP_ReanimatePersistFortifyHealingSpell " + Zombie.HasSpell(NEP_ReanimatePersistFortifyHealingSpell))
  EndIf

  If PlayerRef.HasPerk(DarkSouls)
    Debug.Trace("NEP_ZombieAliasScript: Player has Dark Souls perk")
    Zombie.AddSpell(PerkDarkSoulsZombieBonus)
    Debug.Trace("NEP_ZombieAliasScript: Zombe " + Zombie + " has PerkDarkSoulsZombieBonus " + Zombie.HasSpell(PerkDarkSoulsZombieBonus))
  EndIf

  ReanimateFXShader.Play(Zombie)
  Debug.Trace("NEP_ZombieAliasScript: Played " + ReanimateFXShader + " on " + Zombie)
  MoveZombieToPlayer(Zombie)

EndEvent

Event OnDying(Actor Killer)

  Actor Zombie = Self.GetReference() as Actor

  Self.Clear()

  Debug.Trace("NEP_ZombieAliasScript: OnDying")

  If Zombie.Is3DLoaded()
    ReanimateFXShader.Stop(Zombie)
    Debug.Trace("NEP_ZombieAliasScript: Removed " + ReanimateFXShader + " from " + Zombie)
  EndIf

  If NEP_DeadThrallList.HasForm(Zombie)
    NEP_DeadThrallList.RemoveAddedForm(Zombie)
    Debug.Trace("NEP_ZombieAliasScript: Removed " + Zombie + " from dead thrall tracking list " + !NEP_DeadThrallList.HasForm(Zombie))
    PlayerRef.RemoveSpell(DeadThrall)
  EndIf

EndEvent
