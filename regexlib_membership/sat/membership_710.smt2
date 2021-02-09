;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\s0-9a-zA-Z\;\"\,\<\>\\?\+\=\)\(\\*\&\%\\$\#\.]*
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ""
(define-fun Witness1 () String "")
;witness2: "\u00A1\u008AR"
(define-fun Witness2 () String (seq.++ "\xa1" (seq.++ "\x8a" (seq.++ "R" ""))))

(assert (= regexA (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x22" "&")(re.union (re.range "(" ",")(re.union (re.range "." ".")(re.union (re.range "0" "9")(re.union (re.range ";" "?")(re.union (re.range "A" "Z")(re.union (re.range "\x5c" "\x5c")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
