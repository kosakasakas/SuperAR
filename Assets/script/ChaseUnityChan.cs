using UnityEngine;
using System.Collections;

[RequireComponent(typeof(Animator))]
public class ChaseUnityChan : MonoBehaviour {

	public GameObject chaseTarget = null;
	private Transform targetTransform;
	private Vector3 vec;
	private float speed = 0.015f;

	private Animator animator;
	private int damagingId;

	private int count = 0;
	private int threshold = 3;

	// Use this for initialization
	void Start () {
		targetTransform = chaseTarget.transform;

		animator = GetComponent<Animator> ();
		damagingId = Animator.StringToHash("damaging");
	}
	
	// Update is called once per frame
	void Update () {
		if (CanChase() && animator.GetCurrentAnimatorStateInfo (0).IsName ("Chase")) {
			transform.rotation = Quaternion.Slerp (transform.rotation, Quaternion.LookRotation (targetTransform.position - transform.position), 0.07f);
			transform.position += transform.forward * speed;
		}

		if (Input.GetKey (KeyCode.Return)) {
			animator.SetBool (damagingId, true);
		} else {
			animator.SetBool (damagingId, false);
		}

		if (Input.GetKeyDown (KeyCode.RightShift) && count < threshold) {
			count++;
		}
	}

	bool CanChase() {
		return (count >= threshold);
	}
}
