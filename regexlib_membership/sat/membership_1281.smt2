;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([Vv]+(erdade(iro)?)?|[Ff]+(als[eo])?|[Tt]+(rue)?|0|[\+\-]?1)$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "t"
(define-fun Witness1 () String (str.++ "t" ""))
;witness2: "-1"
(define-fun Witness2 () String (str.++ "-" (str.++ "1" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.+ (re.union (re.range "V" "V") (re.range "v" "v"))) (re.opt (re.++ (str.to_re (str.++ "e" (str.++ "r" (str.++ "d" (str.++ "a" (str.++ "d" (str.++ "e" ""))))))) (re.opt (str.to_re (str.++ "i" (str.++ "r" (str.++ "o" ""))))))))(re.union (re.++ (re.+ (re.union (re.range "F" "F") (re.range "f" "f"))) (re.opt (re.++ (str.to_re (str.++ "a" (str.++ "l" (str.++ "s" "")))) (re.union (re.range "e" "e") (re.range "o" "o")))))(re.union (re.++ (re.+ (re.union (re.range "T" "T") (re.range "t" "t"))) (re.opt (str.to_re (str.++ "r" (str.++ "u" (str.++ "e" ""))))))(re.union (re.range "0" "0") (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.range "1" "1")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
