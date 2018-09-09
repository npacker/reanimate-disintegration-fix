Scriptname NEP_AshPileScript extends ActiveMagicEffect
{Scripted effect for on death ash pile}

;-------------------------------------------------------------------------------
;
; PROPERTIES
;
;-------------------------------------------------------------------------------

EffectShader Property ShockDisintegrate01FXS Auto
{The Effect Shader we want.}

;-------------------------------------------------------------------------------
;
; VARIABLES
;
;-------------------------------------------------------------------------------

Float fDelay = 1.25

Float fDelayEnd = 1.65

Float fShaderDuration = 4.0

Bool AshPileCreated = False

Actor Victim = None

;-------------------------------------------------------------------------------
;
; FUNCTIONS
;
;-------------------------------------------------------------------------------

Function TurnToAsh()

  If AshPileCreated || !Victim.IsDead()
    Return
  EndIf

  Debug.Notification("Disintegrating Zombie.")

  AshPileCreated = True

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateStart)

  If Victim.Is3DLoaded()
    ShockDisintegrate01FXS.Play(Victim, fShaderDuration)
  EndIf

  Utility.Wait(fDelay)
  Victim.AttachAshPile()
  Utility.Wait(fDelayEnd)

  If Victim.Is3DLoaded()
    ShockDisintegrate01FXS.Stop(Victim)
    Victim.SetAlpha(0.0, True)
  EndIf

  Victim.SetCriticalStage(Victim.CritStage_DisintegrateEnd)
  Self.Dispel()

EndFunction

;-------------------------------------------------------------------------------
;
; EVENTS
;
;-------------------------------------------------------------------------------

Event OnEffectStart(Actor Target, Actor Caster)

  Victim = Target
  Debug.Notification("Ash pile effect added to Zombie.")

EndEvent

Event OnDying(Actor Killer)

  TurnToAsh()

EndEvent

Event OnDeath(Actor Killer)

  TurnToAsh()

EndEvent
