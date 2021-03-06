;;;;;Not much goes on here! Provides implementation of the agent class
;;;;;Essentially just some bump detectors and a forward sensor. The interesting
;;;;;stuff happens in the various agent_program methods!

;Agent class with sensor + bump attributes
(defclass agent ()
 ((front_sensor
   :initform (see (get_board world_map)) ;how to make this dyamic?
   :accessor agent_front_sensor_acc)
;;Impossible to bump something on init (as we have never moved)
  (front_bump
   :initform 0
   :accessor agent_front_bump_acc)
  (rear_bump
   :initform 0
   :accessor agent_rear_bump_acc)
  (left_bump
   :initform 0
   :accessor agent_left_bump_acc)
  (right_bump
   :initform 0
   :accessor agent_right_bump_acc)))

;;;Methods for sensors. These are read by the agent program and set by the
;;;simulator
(defmethod sensor_values (agent)
  (list '((agent_front_sensor_acc) 1)))

(defun reset_bump_sensors ()
  (print "Resetting bump sensors")
  (setf (agent_rear_bump_acc agent1) 0)
  (setf (agent_front_bump_acc agent1) 0)
  (setf (agent_left_bump_acc agent1) 0)
  (setf (agent_right_bump_acc agent1) 0))

(defun update_agent (&optional bump)
  (print bump)
  (setf (agent_front_sensor_acc agent1) (see (get_board world_map)))
  (if bump (bump_counter bump))
  (if bump
    (cond
      ((equal bump '(backward)) (setf (agent_rear_bump_acc agent1) 1))
      ((equal bump '(forward)) (setf (agent_front_bump_acc agent1) 1))
      ((equal bump '(left)) (setf (agent_left_bump_acc agent1) 1))
      ((equal bump '(right)) (setf (agent_right_bump_acc agent1) 1)))
    (reset_bump_sensors)) ;If no bump set our sensors back to 0
  (move agent_prog))
