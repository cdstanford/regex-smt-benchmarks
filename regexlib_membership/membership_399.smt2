;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = Password=(?<Password>.*);.*=(?<Info>.*);.*=(?<User>.*);.*=(?<Catalog>.*);.*=(?<Data>.*)
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "D\u00CFPassword=~t;=6;\u00F3=;=;=}"
(define-fun Witness1 () String (str.++ "D" (str.++ "\u{cf}" (str.++ "P" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "=" (str.++ "~" (str.++ "t" (str.++ ";" (str.++ "=" (str.++ "6" (str.++ ";" (str.++ "\u{f3}" (str.++ "=" (str.++ ";" (str.++ "=" (str.++ ";" (str.++ "=" (str.++ "}" "")))))))))))))))))))))))))
;witness2: "\x10Password=;=;=;52=;=D-"
(define-fun Witness2 () String (str.++ "\u{10}" (str.++ "P" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "=" (str.++ ";" (str.++ "=" (str.++ ";" (str.++ "=" (str.++ ";" (str.++ "5" (str.++ "2" (str.++ "=" (str.++ ";" (str.++ "=" (str.++ "D" (str.++ "-" "")))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (str.++ "P" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "=" ""))))))))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range ";" ";")(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (re.range "=" "=") (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
