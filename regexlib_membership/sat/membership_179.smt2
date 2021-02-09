;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \s*("[^"]+"|[^ ,]+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\"\u00A3\x11\"l=\u008E\u00EB"
(define-fun Witness1 () String (seq.++ "\x22" (seq.++ "\xa3" (seq.++ "\x11" (seq.++ "\x22" (seq.++ "l" (seq.++ "=" (seq.++ "\x8e" (seq.++ "\xeb" "")))))))))
;witness2: "\"\'}\"*"
(define-fun Witness2 () String (seq.++ "\x22" (seq.++ "'" (seq.++ "}" (seq.++ "\x22" (seq.++ "*" ""))))))

(assert (= regexA (re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (re.union (re.++ (re.range "\x22" "\x22")(re.++ (re.+ (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.range "\x22" "\x22"))) (re.+ (re.union (re.range "\x00" "\x1f")(re.union (re.range "!" "+") (re.range "-" "\xff"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
