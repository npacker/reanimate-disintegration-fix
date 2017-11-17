Scriptname NEP_ReanimateTrackTargetScript extends Quest
{Script to process and possibly track the target of a reanimate spell.}

Actor Property CurrentReanimateTarget Auto Hidden
{The actor most recently targeted by a reanimate spell.}

ReferenceAlias[] Property ZombieAliases Auto
{Aliases for storing reanimated thrall references.}

Function TrackZombie(Actor Target)

  Bool AliasFound = False
  Int Index = ZombieAliases.Length

  If IsAlreadyTracked(Target)
    Return
  EndIf

  While Index && !AliasFound
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie != None
      If Zombie.IsDead() || Zombie.IsDisabled() || Zombie.IsDeleted()
        If Zombie.IsDead()
          Debug.Trace("Zombie is dead: " + Zombie)
        ElseIf Zombie.IsDisabled()
          Debug.Trace("Zombie is disabled: " + Zombie)
        ElseIf Zombie.IsDeleted()
          Debug.Trace("Zombie is deleted: " + Zombie)
        EndIf

        Zombie.DispelAllSpells()
        Zombie.Kill()
        ZombieAlias.Clear()

        Debug.Trace("Cleaned up zombie " + Zombie + " from reference alias " + ZombieAlias)

        Zombie = None
      EndIf
    EndIf

    If Zombie == None
      AliasFound = True
      ZombieAlias.ForceRefTo(Target as ObjectReference)
      Debug.Trace("Tracked zombie " + Target + " in reference alias " + ZombieAlias)
    EndIf
  EndWhile

EndFunction

Bool Function IsAlreadyTracked(Actor Target)

  Bool ZombieAlreadyTracked = False
  Int Index = ZombieAliases.Length

  While Index && !ZombieAlreadyTracked
    Index -= 1

    ReferenceAlias ZombieAlias = ZombieAliases[Index]
    Actor Zombie = ZombieAlias.GetReference() as Actor

    If Zombie != None
      Debug.Trace(Zombie + " => " + ZombieAlias)
    EndIf

    If Zombie == Target
      ZombieAlreadyTracked = True
      Debug.Trace("Zombie " + Target + " is already tracked.")
    EndIf
  EndWhile

  Return ZombieAlreadyTracked

EndFunction
