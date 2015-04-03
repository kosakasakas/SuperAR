using UnityEngine;
using System.Collections;

public class ChaseUnityChan : MonoBehaviour {

	public GameObject chaseTarget = null;
	private Transform targetTransform;
	private Vector3 vec;
	private float speed = 0.03f;

	// Use this for initialization
	void Start () {
		targetTransform = chaseTarget.transform;
	}
	
	// Update is called once per frame
	void Update () {
		transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(targetTransform.position - transform.position), 0.07f);
		transform.position += transform.forward * speed;
	}
}
