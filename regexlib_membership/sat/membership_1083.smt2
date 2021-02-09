;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [\x01-\x08,\x0A-\x1F,\x7F,\x81,\x8D,\x8F,\x90,\x9D]
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u007F"
(define-fun Witness1 () String (seq.++ "\x7f" ""))
;witness2: "\x15\u0094\u009D@"
(define-fun Witness2 () String (seq.++ "\x15" (seq.++ "\x94" (seq.++ "\x9d" (seq.++ "@" "")))))

(assert (= regexA (re.union (re.range "\x01" "\x08")(re.union (re.range "\x0a" "\x1f")(re.union (re.range "," ",")(re.union (re.range "\x7f" "\x7f")(re.union (re.range "\x81" "\x81")(re.union (re.range "\x8d" "\x8d")(re.union (re.range "\x8f" "\x90") (re.range "\x9d" "\x9d"))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
