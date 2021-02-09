;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[^\\\/\?\*\&quot;\'\&gt;\&lt;\:\|]*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: "]6\u00F7"
(define-fun Witness2 () String (seq.++ "]" (seq.++ "6" (seq.++ "\xf7" ""))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x00" "%")(re.union (re.range "(" ")")(re.union (re.range "+" ".")(re.union (re.range "0" "9")(re.union (re.range "<" ">")(re.union (re.range "@" "[")(re.union (re.range "]" "f")(re.union (re.range "h" "k")(re.union (re.range "m" "n")(re.union (re.range "p" "p")(re.union (re.range "r" "s")(re.union (re.range "v" "{") (re.range "}" "\xff")))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
