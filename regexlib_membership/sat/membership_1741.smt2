;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-Z]{1,2}[1-9][0-9]?[A-Z]? [0-9][A-Z]{2,}|GIR 0AA$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u0095GIR 0AA"
(define-fun Witness1 () String (str.++ "\u{95}" (str.++ "G" (str.++ "I" (str.++ "R" (str.++ " " (str.++ "0" (str.++ "A" (str.++ "A" "")))))))))
;witness2: "FE4D 9MN"
(define-fun Witness2 () String (str.++ "F" (str.++ "E" (str.++ "4" (str.++ "D" (str.++ " " (str.++ "9" (str.++ "M" (str.++ "N" "")))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ ((_ re.loop 1 2) (re.range "A" "Z"))(re.++ (re.range "1" "9")(re.++ (re.opt (re.range "0" "9"))(re.++ (re.opt (re.range "A" "Z"))(re.++ (re.range " " " ")(re.++ (re.range "0" "9") (re.++ ((_ re.loop 2 2) (re.range "A" "Z")) (re.* (re.range "A" "Z")))))))))) (re.++ (str.to_re (str.++ "G" (str.++ "I" (str.++ "R" (str.++ " " (str.++ "0" (str.++ "A" (str.++ "A" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
