using UnityEngine;
using System.Collections;
using UnitySampleAssets.Characters.ThirdPerson;

public class CustomThirdPersonCharacter : ThirdPersonCharacter {

	private bool beam;
	private bool waveHand; 
	public GameObject beamTarget = null;
	public ParticleSystem beamParticle = null;

	// Use this for initialization
	void Start () {
		base.Start ();
	}

	public void MegaBeamStart() {
		beam = true;
	}

	public void MegaBeamStop() {
		beam = false;
	}

	public void WaveHandStart() {
		waveHand = true;
	}

	public void WaveHandStop() {
		waveHand = false;
	}

	protected override void UpdateAnimator()
	{
		UpdateRotation ();

		animator.SetBool("Beam", beam);
		animator.SetBool("WaveHand", waveHand);

		base.UpdateAnimator ();

		UpdateBeamEffect ();

		Debug.Log (beam);
	}

	private void UpdateRotation() {
		if (beamTarget != null && beam) {
			Transform targetTransform = beamTarget.transform;
			transform.rotation = Quaternion.Slerp (transform.rotation, Quaternion.LookRotation (targetTransform.position - transform.position), 0.07f);
		} else if (waveHand) {
			Vector3 cameraPos = Camera.main.transform.position;
			Vector3 targetPos = new Vector3(cameraPos.x, 0.0f, cameraPos.z);
			transform.rotation = Quaternion.Slerp (transform.rotation, Quaternion.LookRotation (targetPos - transform.position), 0.07f);
		}
	}

	private void UpdateBeamEffect() {
		if (!beamParticle) {
			return;
		}

		if (beam) {
			beamParticle.Play();
		} else {
			beamParticle.Stop();
		}
	}
}
