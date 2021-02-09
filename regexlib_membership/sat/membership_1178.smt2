;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?<Sedol>[B-Db-dF-Hf-hJ-Nj-nP-Tp-tV-Xv-xYyZz\d]{6}\d)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\x133BPW929"
(define-fun Witness1 () String (seq.++ "\x13" (seq.++ "3" (seq.++ "B" (seq.++ "P" (seq.++ "W" (seq.++ "9" (seq.++ "2" (seq.++ "9" "")))))))))
;witness2: "6fK8050"
(define-fun Witness2 () String (seq.++ "6" (seq.++ "f" (seq.++ "K" (seq.++ "8" (seq.++ "0" (seq.++ "5" (seq.++ "0" ""))))))))

(assert (= regexA (re.++ ((_ re.loop 6 6) (re.union (re.range "0" "9")(re.union (re.range "B" "D")(re.union (re.range "F" "H")(re.union (re.range "J" "N")(re.union (re.range "P" "T")(re.union (re.range "V" "Z")(re.union (re.range "b" "d")(re.union (re.range "f" "h")(re.union (re.range "j" "n")(re.union (re.range "p" "t") (re.range "v" "z")))))))))))) (re.range "0" "9"))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
