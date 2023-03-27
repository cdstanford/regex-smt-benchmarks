;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ([0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4}|(\d{1,3}\.){3}\d{1,3}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Af:F87b:2:A:Ad:7C8a:8:Df"
(define-fun Witness1 () String (str.++ "A" (str.++ "f" (str.++ ":" (str.++ "F" (str.++ "8" (str.++ "7" (str.++ "b" (str.++ ":" (str.++ "2" (str.++ ":" (str.++ "A" (str.++ ":" (str.++ "A" (str.++ "d" (str.++ ":" (str.++ "7" (str.++ "C" (str.++ "8" (str.++ "a" (str.++ ":" (str.++ "8" (str.++ ":" (str.++ "D" (str.++ "f" "")))))))))))))))))))))))))
;witness2: "9.4.8.7"
(define-fun Witness2 () String (str.++ "9" (str.++ "." (str.++ "4" (str.++ "." (str.++ "8" (str.++ "." (str.++ "7" ""))))))))

(assert (= regexA (re.union (re.++ ((_ re.loop 7 7) (re.++ ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f")))) (re.range ":" ":"))) ((_ re.loop 1 4) (re.union (re.range "0" "9")(re.union (re.range "A" "F") (re.range "a" "f"))))) (re.++ ((_ re.loop 3 3) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.range "." "."))) ((_ re.loop 1 3) (re.range "0" "9"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
