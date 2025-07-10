;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^\d{20}$)|(^((:[a-fA-F0-9]{1,4}){6}|::)ffff:(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})(\.(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[0-9]{1,2})){3}$)|(^((:[a-fA-F0-9]{1,4}){6}|::)ffff(:[a-fA-F0-9]{1,4}){2}$)|(^([a-fA-F0-9]{1,4}) (:[a-fA-F0-9]{1,4}){7}$)|(^:(:[a-fA-F0-9]{1,4}(::)?){1,6}$)|(^((::)?[a-fA-F0-9]{1,4}:){1,6}:$)|(^::$)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ":91c:f898:F:ff:2:F0ffff:208.118.119.249"
(define-fun Witness1 () String (str.++ ":" (str.++ "9" (str.++ "1" (str.++ "c" (str.++ ":" (str.++ "f" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ ":" (str.++ "F" (str.++ ":" (str.++ "f" (str.++ "f" (str.++ ":" (str.++ "2" (str.++ ":" (str.++ "F" (str.++ "0" (str.++ "f" (str.++ "f" (str.++ "f" (str.++ "f" (str.++ ":" (str.++ "2" (str.++ "0" (str.++ "8" (str.++ "." (str.++ "1" (str.++ "1" (str.++ "8" (str.++ "." (str.++ "1" (str.++ "1" (str.++ "9" (str.++ "." (str.++ "2" (str.++ "4" (str.++ "9" ""))))))))))))))))))))))))))))))))))))))))
;witness2: "58987908873948939896"
(define-fun Witness2 () String (str.++ "5" (str.++ "8" (str.++ "9" (str.++ "8" (str.++ "7" (str.++ "9" (str.++ "0" (str.++ "8" (str.++ "8" (str.++ "7" (str.++ "3" (str.++ "9" (str.++ "4" (str.++ "8" (str.++ "9" (str.++ "3" (str.++ "9" (str.++ "8" (str.++ "9" (str.++ "6" "")))))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 20 20) (re.range "0" "9")) (str.to_re "")))(re.union (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 6 6) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))) (str.to_re (str.++ ":" (str.++ ":" ""))))(re.++ (str.to_re (str.++ "f" (str.++ "f" (str.++ "f" (str.++ "f" (str.++ ":" ""))))))(re.++ (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9"))) ((_ re.loop 1 2) (re.range "0" "9")))))(re.++ ((_ re.loop 3 3) (re.++ (re.range "." ".") (re.union (re.++ (str.to_re (str.++ "2" (str.++ "5" ""))) (re.range "0" "5"))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9")))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9"))) ((_ re.loop 1 2) (re.range "0" "9"))))))) (str.to_re ""))))))(re.union (re.++ (str.to_re "")(re.++ (re.union ((_ re.loop 6 6) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))) (str.to_re (str.++ ":" (str.++ ":" ""))))(re.++ (str.to_re (str.++ "f" (str.++ "f" (str.++ "f" (str.++ "f" "")))))(re.++ ((_ re.loop 2 2) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))(re.++ (re.range " " " ")(re.++ ((_ re.loop 7 7) (re.++ (re.range ":" ":") ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))))) (str.to_re "")))))(re.union (re.++ (str.to_re "")(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 6) (re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.opt (str.to_re (str.++ ":" (str.++ ":" ""))))))) (str.to_re ""))))(re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 6) (re.++ (re.opt (str.to_re (str.++ ":" (str.++ ":" ""))))(re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))))(re.++ (re.range ":" ":") (str.to_re "")))) (re.++ (str.to_re "")(re.++ (str.to_re (str.++ ":" (str.++ ":" ""))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
