;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[1-9][0-9]{3}[ ]?(([a-rt-zA-RT-Z]{2})|([sS][^dasDAS]))$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "9098 Wn"
(define-fun Witness1 () String (str.++ "9" (str.++ "0" (str.++ "9" (str.++ "8" (str.++ " " (str.++ "W" (str.++ "n" ""))))))))
;witness2: "1119mh"
(define-fun Witness2 () String (str.++ "1" (str.++ "1" (str.++ "1" (str.++ "9" (str.++ "m" (str.++ "h" "")))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "1" "9")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range " " " "))(re.++ (re.union ((_ re.loop 2 2) (re.union (re.range "A" "R")(re.union (re.range "T" "Z")(re.union (re.range "a" "r") (re.range "t" "z"))))) (re.++ (re.union (re.range "S" "S") (re.range "s" "s")) (re.union (re.range "\u{00}" "@")(re.union (re.range "B" "C")(re.union (re.range "E" "R")(re.union (re.range "T" "`")(re.union (re.range "b" "c")(re.union (re.range "e" "r") (re.range "t" "\u{ff}"))))))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
