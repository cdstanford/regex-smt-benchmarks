;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(GB){0,1}([1-9][0-9]{2}\ [0-9]{4}\ [0-9]{2})|([1-9][0-9]{2}\ [0-9]{4}\ [0-9]{2}\ [0-9]{3})|((GD|HA)[0-9]{3})$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "GB880 9198 85\u00CA"
(define-fun Witness1 () String (str.++ "G" (str.++ "B" (str.++ "8" (str.++ "8" (str.++ "0" (str.++ " " (str.++ "9" (str.++ "1" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "8" (str.++ "5" (str.++ "\u{ca}" "")))))))))))))))
;witness2: "159 6435 81\u00B8\x1E\u00E4\u00B1\u00F79"
(define-fun Witness2 () String (str.++ "1" (str.++ "5" (str.++ "9" (str.++ " " (str.++ "6" (str.++ "4" (str.++ "3" (str.++ "5" (str.++ " " (str.++ "8" (str.++ "1" (str.++ "\u{b8}" (str.++ "\u{1e}" (str.++ "\u{e4}" (str.++ "\u{b1}" (str.++ "\u{f7}" (str.++ "9" ""))))))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.opt (str.to_re (str.++ "G" (str.++ "B" "")))) (re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 2 2) (re.range "0" "9")))))))))(re.union (re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.range " " " ")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.range " " " ") ((_ re.loop 3 3) (re.range "0" "9"))))))))) (re.++ (re.++ (re.union (str.to_re (str.++ "G" (str.++ "D" ""))) (str.to_re (str.++ "H" (str.++ "A" "")))) ((_ re.loop 3 3) (re.range "0" "9"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
