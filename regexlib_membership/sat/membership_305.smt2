;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([A-Z]{1}[a-z]+([\-][A-Z]{1}[a-z]+)?)([ ]([A-Z]\.)){0,2}[ ](([A-Z]{1}[a-z]*)|([O]{1}[\']{1}[A-Z][a-z]{2,}))([ ](Jr\.|Sr\.|IV|III|II))?)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Yqv-Yd P. R. O\'Ibage III"
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "q" (seq.++ "v" (seq.++ "-" (seq.++ "Y" (seq.++ "d" (seq.++ " " (seq.++ "P" (seq.++ "." (seq.++ " " (seq.++ "R" (seq.++ "." (seq.++ " " (seq.++ "O" (seq.++ "'" (seq.++ "I" (seq.++ "b" (seq.++ "a" (seq.++ "g" (seq.++ "e" (seq.++ " " (seq.++ "I" (seq.++ "I" (seq.++ "I" "")))))))))))))))))))))))))
;witness2: "Ff-Ca Z. O\'Nea Jr."
(define-fun Witness2 () String (seq.++ "F" (seq.++ "f" (seq.++ "-" (seq.++ "C" (seq.++ "a" (seq.++ " " (seq.++ "Z" (seq.++ "." (seq.++ " " (seq.++ "O" (seq.++ "'" (seq.++ "N" (seq.++ "e" (seq.++ "a" (seq.++ " " (seq.++ "J" (seq.++ "r" (seq.++ "." "")))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.++ (re.range "A" "Z")(re.++ (re.+ (re.range "a" "z")) (re.opt (re.++ (re.range "-" "-")(re.++ (re.range "A" "Z") (re.+ (re.range "a" "z")))))))(re.++ ((_ re.loop 0 2) (re.++ (re.range " " " ") (re.++ (re.range "A" "Z") (re.range "." "."))))(re.++ (re.range " " " ")(re.++ (re.union (re.++ (re.range "A" "Z") (re.* (re.range "a" "z"))) (re.++ (str.to_re (seq.++ "O" (seq.++ "'" "")))(re.++ (re.range "A" "Z") (re.++ ((_ re.loop 2 2) (re.range "a" "z")) (re.* (re.range "a" "z")))))) (re.opt (re.++ (re.range " " " ") (re.union (str.to_re (seq.++ "J" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "S" (seq.++ "r" (seq.++ "." ""))))(re.union (str.to_re (seq.++ "I" (seq.++ "V" "")))(re.union (str.to_re (seq.++ "I" (seq.++ "I" (seq.++ "I" "")))) (str.to_re (seq.++ "I" (seq.++ "I" ""))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
