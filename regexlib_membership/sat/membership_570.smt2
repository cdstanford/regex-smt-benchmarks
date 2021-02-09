;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ((^(?<property>\S+):)|(\s(?<property>)))(?<value>.*)\n
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00A0\u008B\xA"
(define-fun Witness1 () String (seq.++ "\xa0" (seq.++ "\x8b" (seq.++ "\x0a" ""))))
;witness2: "\xC\u00AF\u00C1\xAXm"
(define-fun Witness2 () String (seq.++ "\x0c" (seq.++ "\xaf" (seq.++ "\xc1" (seq.++ "\x0a" (seq.++ "X" (seq.++ "m" "")))))))

(assert (= regexA (re.++ (re.union (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))) (re.range ":" ":"))) (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (str.to_re "")))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.range "\x0a" "\x0a")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
