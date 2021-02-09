;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^A-Za-z0-9_@\.]|@{2,}|\.{5,}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: ",\u00B4\u00E3?f......\u00B9\u00D8"
(define-fun Witness1 () String (seq.++ "," (seq.++ "\xb4" (seq.++ "\xe3" (seq.++ "?" (seq.++ "f" (seq.++ "." (seq.++ "." (seq.++ "." (seq.++ "." (seq.++ "." (seq.++ "." (seq.++ "\xb9" (seq.++ "\xd8" ""))))))))))))))
;witness2: "\u00AD"
(define-fun Witness2 () String (seq.++ "\xad" ""))

(assert (= regexA (re.union (re.union (re.range "\x00" "-")(re.union (re.range "/" "/")(re.union (re.range ":" "?")(re.union (re.range "[" "^")(re.union (re.range "`" "`") (re.range "{" "\xff"))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "@" "@")) (re.* (re.range "@" "@"))) (re.++ ((_ re.loop 5 5) (re.range "." ".")) (re.* (re.range "." ".")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
