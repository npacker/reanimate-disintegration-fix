Scriptname NEP_ReanimateFixLib

Function CleanUpZombie(ReferenceAlias ZombieAlias, Actor Zombie, FormList Factions) Global

  Zombie.Kill()
  ZombieAlias.Clear()

  Int Index = Factions.GetSize()

  While Index
    Index -= 1
    Zombie.RemoveFromFaction(Factions.GetAt(Index) as Faction)
  EndWhile

EndFunction

Function MoveZombieToPlayer(Actor Zombie, Actor Player) Global

  Cell ZombieCell = Zombie.GetParentCell()
  Cell PlayerCell = Player.GetParentCell()

  If ZombieCell != PlayerCell
    If ZombieCell && ZombieCell.IsInterior() \
        || PlayerCell && PlayerCell.IsInterior()
      Float fOffsetDistance = 100.0
      Float XOffset = Math.Sin(Player.GetAngleZ()) * fOffsetDistance
      Float YOffset = Math.Cos(Player.GetAngleZ()) * fOffsetDistance
      Float ZOffset = 0.0

      Zombie.MoveTo(Player, XOffset, YOffset, ZOffset, True)
    EndIf
  EndIf

EndFunction

Bool Function ZombieHasExpired(Actor Zombie) Global

  Return Zombie.IsDead() || Zombie.IsDisabled() || Zombie.IsDeleted() \
      || !Zombie.IsCommandedActor()

EndFunction
