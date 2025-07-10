;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (pwd|password)\s*=\s*(?<pwd>('(([^'])|(''))+'|[^';]+))
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "pwd=\'I\u009A\'"
(define-fun Witness1 () String (str.++ "p" (str.++ "w" (str.++ "d" (str.++ "=" (str.++ "'" (str.++ "I" (str.++ "\u{9a}" (str.++ "'" "")))))))))
;witness2: "\u00E6\x15\u00EEpassword=\x9B"
(define-fun Witness2 () String (str.++ "\u{e6}" (str.++ "\u{15}" (str.++ "\u{ee}" (str.++ "p" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" (str.++ "=" (str.++ "\u{09}" (str.++ "B" "")))))))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (str.++ "p" (str.++ "w" (str.++ "d" "")))) (str.to_re (str.++ "p" (str.++ "a" (str.++ "s" (str.++ "s" (str.++ "w" (str.++ "o" (str.++ "r" (str.++ "d" ""))))))))))(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.range "=" "=")(re.++ (re.* (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))) (re.union (re.++ (re.range "'" "'")(re.++ (re.+ (re.union (re.union (re.range "\u{00}" "&") (re.range "(" "\u{ff}")) (str.to_re (str.++ "'" (str.++ "'" ""))))) (re.range "'" "'"))) (re.+ (re.union (re.range "\u{00}" "&")(re.union (re.range "(" ":") (re.range "<" "\u{ff}")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
