;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [^A-Za-z0-9_@\.]|@{2,}|\.{5,}
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: ",\u00B4\u00E3?f......\u00B9\u00D8"
(define-fun Witness1 () String (str.++ "," (str.++ "\u{b4}" (str.++ "\u{e3}" (str.++ "?" (str.++ "f" (str.++ "." (str.++ "." (str.++ "." (str.++ "." (str.++ "." (str.++ "." (str.++ "\u{b9}" (str.++ "\u{d8}" ""))))))))))))))
;witness2: "\u00AD"
(define-fun Witness2 () String (str.++ "\u{ad}" ""))

(assert (= regexA (re.union (re.union (re.range "\u{00}" "-")(re.union (re.range "/" "/")(re.union (re.range ":" "?")(re.union (re.range "[" "^")(re.union (re.range "`" "`") (re.range "{" "\u{ff}"))))))(re.union (re.++ ((_ re.loop 2 2) (re.range "@" "@")) (re.* (re.range "@" "@"))) (re.++ ((_ re.loop 5 5) (re.range "." ".")) (re.* (re.range "." ".")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
