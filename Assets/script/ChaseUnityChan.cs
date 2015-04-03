using UnityEngine;
using System.Collections;

[RequireComponent(typeof(Animator))]
public class ChaseUnityChan : MonoBehaviour {

	public GameObject chaseTarget = null;
	private Transform targetTransform;
	private Vector3 vec;
	private float speed = 0.03f;

	private Animator animator;
	private int damagingId;

	// Use this for initialization
	void Start () {
		targetTransform = chaseTarget.transform;

		animator = GetComponent<Animator> ();
		damagingId = Animator.StringToHash("damaging");
	}
	
	// Update is called once per frame
	void Update () {
		if (animator.GetCurrentAnimatorStateInfo (0).IsName ("Chase")) {
			transform.rotation = Quaternion.Slerp (transform.rotation, Quaternion.LookRotation (targetTransform.position - transform.position), 0.07f);
			transform.position += transform.forward * speed;
		}

		if (Input.GetKey (KeyCode.Return)) {
			animator.SetBool (damagingId, true);
		} else {
			animator.SetBool (damagingId, false);
		}
	}
}
