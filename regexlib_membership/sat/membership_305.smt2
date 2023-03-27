;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([A-Z]{1}[a-z]+([\-][A-Z]{1}[a-z]+)?)([ ]([A-Z]\.)){0,2}[ ](([A-Z]{1}[a-z]*)|([O]{1}[\']{1}[A-Z][a-z]{2,}))([ ](Jr\.|Sr\.|IV|III|II))?)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Yqv-Yd P. R. O\'Ibage III"
(define-fun Witness1 () String (str.++ "Y" (str.++ "q" (str.++ "v" (str.++ "-" (str.++ "Y" (str.++ "d" (str.++ " " (str.++ "P" (str.++ "." (str.++ " " (str.++ "R" (str.++ "." (str.++ " " (str.++ "O" (str.++ "'" (str.++ "I" (str.++ "b" (str.++ "a" (str.++ "g" (str.++ "e" (str.++ " " (str.++ "I" (str.++ "I" (str.++ "I" "")))))))))))))))))))))))))
;witness2: "Ff-Ca Z. O\'Nea Jr."
(define-fun Witness2 () String (str.++ "F" (str.++ "f" (str.++ "-" (str.++ "C" (str.++ "a" (str.++ " " (str.++ "Z" (str.++ "." (str.++ " " (str.++ "O" (str.++ "'" (str.++ "N" (str.++ "e" (str.++ "a" (str.++ " " (str.++ "J" (str.++ "r" (str.++ "." "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z")) (re.opt (re.++ (re.range "-" "-")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))))(re.++ ((_ re.loop 0 2) (re.++ (re.range " " " ") (re.++ (re.range "A" "Z") (re.range "." "."))))(re.++ (re.range " " " ")(re.++ (re.union (re.++ (re.range "A" "Z") (re.* (re.range "a" "z"))) (re.++ (str.to_re (str.++ "O" (str.++ "'" "")))(re.++ (re.range "A" "Z") (re.++ ((_ re.loop 2 2) (re.range "a" "z")) (re.* (re.range "a" "z")))))) (re.opt (re.++ (re.range " " " ") (re.union (str.to_re (str.++ "J" (str.++ "r" (str.++ "." ""))))(re.union (str.to_re (str.++ "S" (str.++ "r" (str.++ "." ""))))(re.union (str.to_re (str.++ "I" (str.++ "V" "")))(re.union (str.to_re (str.++ "I" (str.++ "I" (str.++ "I" "")))) (str.to_re (str.++ "I" (str.++ "I" ""))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
