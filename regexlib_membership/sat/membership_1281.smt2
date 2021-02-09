;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([Vv]+(erdade(iro)?)?|[Ff]+(als[eo])?|[Tt]+(rue)?|0|[\+\-]?1)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "t"
(define-fun Witness1 () String (seq.++ "t" ""))
;witness2: "-1"
(define-fun Witness2 () String (seq.++ "-" (seq.++ "1" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.+ (re.union (re.range "V" "V") (re.range "v" "v"))) (re.opt (re.++ (str.to_re (seq.++ "e" (seq.++ "r" (seq.++ "d" (seq.++ "a" (seq.++ "d" (seq.++ "e" ""))))))) (re.opt (str.to_re (seq.++ "i" (seq.++ "r" (seq.++ "o" ""))))))))(re.union (re.++ (re.+ (re.union (re.range "F" "F") (re.range "f" "f"))) (re.opt (re.++ (str.to_re (seq.++ "a" (seq.++ "l" (seq.++ "s" "")))) (re.union (re.range "e" "e") (re.range "o" "o")))))(re.union (re.++ (re.+ (re.union (re.range "T" "T") (re.range "t" "t"))) (re.opt (str.to_re (seq.++ "r" (seq.++ "u" (seq.++ "e" ""))))))(re.union (re.range "0" "0") (re.++ (re.opt (re.union (re.range "+" "+") (re.range "-" "-"))) (re.range "1" "1")))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
