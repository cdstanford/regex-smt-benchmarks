;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <([^\s>]*)(\s[^<]*)>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<\u007F\u00DD\u0085j7\'\x1E\u00AF>\u00FD\u00D4\u00FC"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "\x7f" (seq.++ "\xdd" (seq.++ "\x85" (seq.++ "j" (seq.++ "7" (seq.++ "'" (seq.++ "\x1e" (seq.++ "\xaf" (seq.++ ">" (seq.++ "\xfd" (seq.++ "\xd4" (seq.++ "\xfc" ""))))))))))))))
;witness2: "\u00C3<\u008E\xB>\x3\u00ACQ\u00BC"
(define-fun Witness2 () String (seq.++ "\xc3" (seq.++ "<" (seq.++ "\x8e" (seq.++ "\x0b" (seq.++ ">" (seq.++ "\x03" (seq.++ "\xac" (seq.++ "Q" (seq.++ "\xbc" ""))))))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.* (re.union (re.range "\x00" "\x08")(re.union (re.range "\x0e" "\x1f")(re.union (re.range "!" "=")(re.union (re.range "?" "\x84")(re.union (re.range "\x86" "\x9f") (re.range "\xa1" "\xff")))))))(re.++ (re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) (re.* (re.union (re.range "\x00" ";") (re.range "=" "\xff")))) (re.range ">" ">"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
