Scriptname NEP_ReanimateTrackTargetScript extends Quest
{Script to process and possibly track the target of a reanimate spell.}

Actor Property CurrentReanimateTarget Auto
{The actor most recently targeted by a reanimate spell.}

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

Function TrackZombie()

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  If ZombieAlreadyTracked()
    Return
  EndIf

  While Index && !AliasFound
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie != None
      If Zombie.IsDead() || Zombie.IsDisabled() || Zombie.IsDeleted()
        Zombie.DispelAllSpells()
        Zombie.Kill()
        ZombieAlias.Clear()

        Debug.Trace("Cleaned up zombie " + Zombie + " from reference alias " + ZombieAlias)

        Zombie = None
      EndIf
    EndIf

    If Zombie == None
      AliasFound = True
      ZombieAlias.ForceRefTo(CurrentReanimateTarget as ObjectReference)
      Debug.Trace("Tracked zombie " + CurrentReanimateTarget + " in reference alias " + ZombieAlias)
      CurrentReanimateTarget = None
    EndIf
  EndWhile

EndFunction

Bool Function ZombieAlreadyTracked()

  Bool bZombieAlreadyTracked = False
  Int Index = ZombieAliases.Length

  While Index && !bZombieAlreadyTracked
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie != None
      Debug.Trace(Zombie + " => " + ZombieAlias)
    EndIf

    If Zombie == CurrentReanimateTarget
      bZombieAlreadyTracked = True
      Debug.Trace("Zombie " + CurrentReanimateTarget + " is already tracked.")
    EndIf
  EndWhile

  Return bZombieAlreadyTracked

EndFunction
