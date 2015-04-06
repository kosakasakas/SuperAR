using UnityEngine;
using System.Collections;
using UnitySampleAssets.Characters.ThirdPerson;

public class CustomThirdPersonCharacter : ThirdPersonCharacter {

	private bool beam;
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

	protected override void UpdateAnimator()
	{
		UpdateRotation ();

		animator.SetBool("Beam", beam);

		base.UpdateAnimator ();

		UpdateBeamEffect ();

		Debug.Log (beam);
	}

	private void UpdateRotation() {
		if (beamTarget != null && beam) {
			Transform targetTransform = beamTarget.transform;
			transform.rotation = Quaternion.Slerp (transform.rotation, Quaternion.LookRotation (targetTransform.position - transform.position), 0.07f);
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
