;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<Code>([^"']|"[^"]*")*)'(?<Comment>.*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"\u00B6\"\'\u009F\u00C7\x13"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "\xb6" (seq.++ "\x22" (seq.++ "'" (seq.++ "\x9f" (seq.++ "\xc7" (seq.++ "\x13" ""))))))))
;witness2: "\"\"\u00E3\'\u00C1"
(define-fun Witness2 () String (seq.++ "\x22" (seq.++ "\x22" (seq.++ "\xe3" (seq.++ "'" (seq.++ "\xc1" ""))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.union (re.range "\x00" "!")(re.union (re.range "#" "&") (re.range "(" "\xff"))) (re.++ (re.range "\x22" "\x22")(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22")))))(re.++ (re.range "'" "'")(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
