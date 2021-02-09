;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (^[A-Z]{1,2}[0-9]{1,}:{1}[A-Z]{1,2}[0-9]{1,}$)|(^\$(([A-Z])|([a-z])){1,2}([0-9]){1,}:{1}\$(([A-Z])|([a-z])){1,2}([0-9]){1,}$)|(^\$(([A-Z])|([a-z])){1,2}(\$){1}([0-9]){1,}:{1}\$(([A-Z])|([a-z])){1,2}(\$){1}([0-9]){1,}$)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "$C0:$g8"
(define-fun Witness1 () String (seq.++ "$" (seq.++ "C" (seq.++ "0" (seq.++ ":" (seq.++ "$" (seq.++ "g" (seq.++ "8" ""))))))))
;witness2: "N58:K97"
(define-fun Witness2 () String (seq.++ "N" (seq.++ "5" (seq.++ "8" (seq.++ ":" (seq.++ "K" (seq.++ "9" (seq.++ "7" ""))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "A" "Z"))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.range ":" ":")(re.++ ((_ re.loop 1 2) (re.range "A" "Z"))(re.++ (re.+ (re.range "0" "9")) (str.to_re "")))))))(re.union (re.++ (str.to_re "")(re.++ (re.range "$" "$")(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.+ (re.range "0" "9"))(re.++ (str.to_re (seq.++ ":" (seq.++ "$" "")))(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.+ (re.range "0" "9")) (str.to_re "")))))))) (re.++ (str.to_re "")(re.++ (re.range "$" "$")(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "$" "$")(re.++ (re.+ (re.range "0" "9"))(re.++ (str.to_re (seq.++ ":" (seq.++ "$" "")))(re.++ ((_ re.loop 1 2) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.range "$" "$")(re.++ (re.+ (re.range "0" "9")) (str.to_re ""))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
